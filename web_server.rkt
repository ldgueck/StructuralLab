#lang racket
(require web-server/servlet web-server/servlet-env json racket/draw racket/class racket/runtime-path "Luokat.rkt")

(define-runtime-path root-dir ".")
(define-runtime-path material-file "materials.rktd")
(define-runtime-path html-file "studio.html")

;; Ladataan tietokanta turvallisesti
(define material-db 
  (if (file-exists? material-file)
      (with-input-from-file material-file read)
      (begin (displayln "VAROITUS: materials.rktd puuttuu!") '())))

(define (build-stack raw-text)
  (let ([lines (string-split (or raw-text "") "\n")] [stack '()] [current-y 0.0])
    (for ([line lines])
      (let* ([clean (string-replace line "," " ")]
             [parts (filter (lambda (s) (not (string=? s ""))) (string-split (string-downcase (string-trim clean))))]
             [cmd-str (if (empty? parts) #f (first parts))]
             [cmd (if cmd-str (string->symbol cmd-str) #f)]
             [dna (if cmd (assoc cmd material-db) #f)])
        (when dna
          (let* ([val (if (> (length parts) 1) (string->number (second parts)) #f)]
                 [spec (second dna)]
                 [m-class (case cmd [(eriste villa) eriste%] [(puu palkki) puu%] [else material-base%])]
                 [mat (new m-class [id (symbol->string cmd)] [name-fi (cdr (assoc 'n-fi spec))] [color (cdr (assoc 'c spec))] [lambda (cdr (assoc 'lambda spec))])]
                 [h (or val (cdr (assoc 'h-std spec)))]
                 [lyr (new layer% [material mat] [w 1200.0] [h h] [y-offset current-y])])
            (set! stack (cons lyr stack)) (set! current-y (+ current-y h))))))
    (values (reverse stack) current-y)))

(define (draw-everything dc stack pid did h-total)
  (send dc start-doc "StructuralLab") (send dc start-page)
  (send dc translate 400 500)
  (send dc set-scale 0.3 -0.3)
  (for ([l stack]) (send l render dc))
  (send dc set-scale 1 1)
  (send dc set-font (make-object font% 11 'modern 'normal 'bold))
  (send dc draw-text (format "PROJEKTI: ~a   DETALI: ~a" pid did) -380 40)
  (send dc draw-text (format "KOKONAISKORKEUS: ~a mm" h-total) -380 60)
  (send dc end-page) (send dc end-doc))

;; Korjattu projektilistaus: näyttää vain nimet, ei koko polkua
(define (list-projects)
  (let ([p-dir (build-path root-dir "projects")])
    (if (directory-exists? p-dir)
        (for/list ([p (directory-list p-dir)] #:when (directory-exists? (build-path p-dir p)))
          (hasheq 'name (path->string p) 
                  'details (map path->string (directory-list (build-path p-dir p)))))
        '())))

(define (start req)
  (let* ([params (request-bindings req)] [uri (url->string (request-uri req))]
         [txt (if (exists-binding? 'txt params) (extract-binding/single 'txt params) "")]
         [pid (if (exists-binding? 'id params) (extract-binding/single 'id params) "P-101")]
         [did (if (exists-binding? 'did params) (extract-binding/single 'did params) "D-01")])
    (define-values (stack h-total) (build-stack txt))
    (cond 
      [(string-contains? uri "get-svg")
       (let ([out (open-output-string)]) 
         (draw-everything (new svg-dc% [output out] [width 800] [height 600]) stack pid did h-total)
         (response/full 200 #"OK" (current-seconds) #"image/svg+xml" '() (list (string->bytes/utf-8 (get-output-string out)))))]
      [(string-contains? uri "list-projects") 
       (response/full 200 #"OK" (current-seconds) #"application/json" '() (list (jsexpr->bytes (list-projects))))]
      [(string-contains? uri "save-pdf")
       (let* ([path (build-path root-dir "projects" pid did)]
              [pdf-file (build-path path "kuva.pdf")])
         (make-directory* path)
         ;; KORJAUS: Lisätty interactive? #f jotta Windows ei avaa dialogia
         (draw-everything (new pdf-dc% [output pdf-file] [interactive? #f] [width 595] [height 842]) stack pid did h-total)
         (with-output-to-file (build-path path "design.txt") #:exists 'replace (lambda () (display txt)))
         (response/full 200 #"OK" (current-seconds) #"text/plain" '() (list #"Valmis")))]
      [else (response/full 200 #"OK" (current-seconds) #"text/html; charset=utf-8" '() (list (file->bytes html-file)))])))

(serve/servlet start #:port 8888 #:listen-ip #f #:servlet-path "/" #:servlet-regexp #rx"" #:command-line? #t)