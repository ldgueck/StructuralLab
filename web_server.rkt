#lang racket
(require web-server/servlet web-server/servlet-env json racket/draw racket/class racket/runtime-path "Luokat.rkt")

(define-runtime-path root-dir ".")
(define-runtime-path material-file "materials.rktd")
(define-runtime-path config-file "display_config.txt")
(define-runtime-path html-file "studio.html")

(define material-db (if (file-exists? material-file) (with-input-from-file material-file read) '()))
(define display-cfg (if (file-exists? config-file) (with-input-from-file config-file read) '()))

(define (get-cfg group key default)
  (let* ([g (assoc group display-cfg)] [v (if g (assoc key (second g)) #f)]) (if v (cdr v) default)))

(define (build-stack raw-text)
  (let ([lines (string-split (or raw-text "") "\n")]
        [stack '()] [current-y 0.0]
        [last-main-w 0.0] [last-main-cc #f] [layer-base-y 0.0] [infill-sub-y 0.0])
    (for ([line lines])
      (let* ([is-infill (string-prefix? (string-trim line) "+")]
             [clean (string-replace (string-replace line "+" "") "," " ")]
             [parts (filter (lambda (s) (not (string=? s ""))) (string-split (string-downcase (string-trim clean))))]
             [cmd-str (if (empty? parts) #f (first parts))]
             [cmd (if cmd-str (string->symbol cmd-str) #f)]
             [dna (if cmd (assoc cmd material-db) #f)])
        (when dna
          (let* ([m-spec (second dna)]
                 [h (or (if (> (length parts) 1) (string->number (second parts)) #f) (cdr (assoc 'h-std m-spec)))]
                 [w (or (if (> (length parts) 2) (string->number (third parts)) #f) 1200.0)]
                 [k-pos (member "k" parts)]
                 [cc (if (and k-pos (> (length k-pos) 1)) (string->number (second k-pos)) #f)]
                 [m-class (cond [(member cmd '(eriste villa)) eriste%]
                                [(member cmd '(puu palkki)) puu%]
                                [else material-base%])]
                 [mat (new m-class [id (symbol->string cmd)] [name-fi (cdr (assoc 'n-fi m-spec))] 
                                   [color (cdr (assoc 'c m-spec))] [lambda (cdr (assoc 'lambda m-spec))] 
                                   [density (let ([d (assoc 'density m-spec)]) (if d (cdr d) 0.0))]
                                   [parent-w last-main-w] [parent-cc last-main-cc])])
            (cond
              [is-infill
               (set! stack (cons (new layer% [material mat] [w w] [h h] 
                                             [y-offset (+ layer-base-y infill-sub-y)] [cc cc]) stack))
               (set! infill-sub-y (+ infill-sub-y h))]
              [else
               (set! last-main-w w) (set! last-main-cc cc) (set! layer-base-y current-y) (set! infill-sub-y 0.0)
               (set! stack (cons (new layer% [material mat] [w w] [h h] [y-offset current-y] [cc cc]) stack))
               (set! current-y (+ current-y h))])))))
    (values (reverse stack) current-y)))

(define (draw-everything dc stack pid did h-total)
  (let-values ([(canvas-w canvas-h) (send dc get-size)])
    (send dc start-doc "StructuralLab") (send dc start-page)
    (let* ([ox (* canvas-w 0.5)] [oy (* canvas-h 0.45)] [s 0.45]
           [clip-w (* 1205 s)] [clip-x (- ox (/ clip-w 2))]
           [clip-h (* 4000 s)] [clip-y (- oy clip-h)])
      (send dc set-clipping-rect clip-x clip-y clip-w clip-h)
      (send dc translate ox oy) (send dc set-scale s (- s))
      (for ([l stack]) (send l render dc))
      (send dc set-clipping-region #f)
      (send dc set-scale 1.0 1.0) (send dc translate (- ox) (- oy)))
    (send dc set-font (make-object font% 11 'modern 'normal 'bold))
    (send dc draw-text (format "PROJEKTI: ~a   KORKEUS: ~a mm" pid h-total) 40 (- canvas-h 60))
    (send dc end-page) (send dc end-doc)) #t)

(define (list-projects)
  (let ([p-dir (build-path root-dir "projects")])
    (if (directory-exists? p-dir)
        (for/list ([p (directory-list p-dir)] #:when (directory-exists? (build-path p-dir p)))
          (hasheq 'name (path->string p) 'details (map path->string (directory-list (build-path p-dir p)))))
        '())))

(define (start req)
  (let* ([params (request-bindings req)] [uri (url->string (request-uri req))]
         [txt (if (exists-binding? 'txt params) (extract-binding/single 'txt params) "")]
         [pid (if (exists-binding? 'id params) (extract-binding/single 'id params) "P-101")]
         [did (if (exists-binding? 'did params) (extract-binding/single 'did params) "D-01")]
         [st (if (exists-binding? 'st params) (extract-binding/single 'st params) "ulkoseinä")])
    (define-values (stack h-total) (build-stack txt))
    (cond 
      [(string-contains? uri "get-svg")
       (let ([out (open-output-string)]
             [u-val (let ([R (+ (for/sum ([l stack]) (send l calculate-r-value)) (get-surface-resistance st))]) (if (> R 0.2) (/ 1.0 R) 0))]
             [wgt (for/sum ([l stack]) (send l calculate-weight))])
         (draw-everything (new svg-dc% [output out] [width 800] [height 600]) stack pid did h-total)
         (response/full 200 #"OK" (current-seconds) #"application/json" '() 
            (list (jsexpr->bytes (hasheq 'svg (get-output-string out) 'u_val (real->decimal-string u-val 3) 'h_total h-total 'weight (real->decimal-string wgt 1))))))]
      [(string-contains? uri "list-projects") 
       (response/full 200 #"OK" (current-seconds) #"application/json" '() (list (jsexpr->bytes (list-projects))))]
      [(string-contains? uri "save-pdf")
       (let* ([path (build-path root-dir "projects" pid did)] [pdf-file (build-path path "kuva.pdf")])
         (make-directory* path)
         (draw-everything (new pdf-dc% [output pdf-file] [interactive? #f] [width 595] [height 842]) stack pid did h-total)
         (with-output-to-file (build-path path "design.txt") #:exists 'replace (lambda () (display txt)))
         (response/full 200 #"OK" (current-seconds) #"text/plain" '() (list #"Valmis")))]
      [else (response/full 200 #"OK" (current-seconds) #"text/html; charset=utf-8" '() (list (file->bytes html-file)))])))

(serve/servlet start #:port 8888 #:listen-ip #f #:servlet-path "/" #:servlet-regexp #rx"" #:command-line? #t)