#lang racket
(require racket/draw racket/class)
(provide (all-defined-out))

;; --- APUFUNKTIOT ---
(define (hex->color hex-str)
  (let* ([h (string-replace (if (string? hex-str) hex-str "#808080") "#" "")]
         [r (string->number (substring h 0 2) 16)]
         [g (string->number (substring h 2 4) 16)]
         [b (string->number (substring h 4 6) 16)])
    (make-object color% r g b)))

;; ADAPTIVE ZIGZAG: Piirtää siksakin viivoina
(define (draw-robust-zigzag dc x1 x2 y h)
  (let* ([width (- x2 x1)]
         [target-step 35]
         [count (max 1 (exact-round (/ width target-step)))]
         [actual-step (/ width count)])
    (begin
      (send dc set-brush "black" 'transparent)
      (send dc set-pen "black" 1.2 'solid)
      (for ([i (in-range count)])
        (let ([p1 (+ x1 (* i actual-step))]
              [p-mid (+ x1 (* i actual-step) (/ actual-step 2))]
              [p-end (+ x1 (* (+ i 1) actual-step))])
          (send dc draw-line p1 y p-mid (+ y h))
          (send dc draw-line p-mid (+ y h) p-end y))))))

;; --- PERUSLUOKKA (Nyt yhteensopiva kaikkien init-argumenttien kanssa) ---
(define material-base%
  (class object% 
    (super-new)
    (init-field id name-fi color lambda density 
                [parent-w 0] [parent-cc #f]) ;; Lisätty kantaan jotta 'new' ei kaadu
    
    (define/public (draw dc w h y [cc #f])
      (begin
        (send dc set-brush "white" 'transparent)
        (send dc set-pen "black" 1.2 'solid)
        (if (and cc (> cc 0))
            (let ([centers (sort (append (for/list ([i (in-range 0 1201 cc)]) i)
                                         (for/list ([i (in-range (- cc) -1201 (- cc))]) i)) <)])
              (for ([c centers])
                (let ([xl (- c (/ w 2))] 
                      [xr (+ c (/ w 2))])
                  (when (and (< xl 600) (> xr -600))
                    (send dc draw-rectangle (max -600 xl) y (- (min 600 xr) (max -600 xl)) h)))))
            (send dc draw-rectangle (- (/ w 2)) y w h))))

    (define/public (calculate-weight-in-layer w h cc)
      (let ([rho density])
        (if (and cc (> cc 0)) 
            (* (/ h 1000.0) rho (/ w cc)) 
            (* (/ h 1000.0) rho))))))

;; --- PUU / RANKA ---
(define puu%
  (class material-base% 
    (super-new)
    (define/override (draw dc w h y [cc #f])
      (begin
        (super draw dc w h y cc)
        (send dc set-pen "black" 1.2 'solid)
        (let ([centers (if (and cc (> cc 0))
                           (sort (append (for/list ([i (in-range 0 1201 cc)]) i)
                                         (for/list ([i (in-range (- cc) -1201 (- cc))]) i)) <)
                           '(0))])
          (for ([c centers])
            (let ([xl (- c (/ w 2))] 
                  [xr (+ c (/ w 2))])
              (when (and (< xl 600) (> xr -600))
                (send dc draw-line (max -600 xl) y (min 600 xr) (+ y h))
                (send dc draw-line (min 600 xr) y (max -600 xl) (+ y h))))))))))

;; --- ERISTE (Nyt käyttää kannasta perittyjä parent-w ja parent-cc arvoja) ---
(define eriste%
  (class material-base% 
    (super-new)
    (define/override (draw dc w h y [cc #f])
      ;; Käytetään joko kerroksen omaa cc:tä tai edellisen kantavan osan cc:tä
      (let ([use-cc (or cc (get-field parent-cc this))]
            [p-w (get-field parent-w this)])
        (if (and use-cc (> use-cc 0) (> p-w 0))
            (let ([centers (sort (append (for/list ([i (in-range 0 1201 use-cc)]) i)
                                         (for/list ([i (in-range (- use-cc) -1201 (- use-cc))]) i)) <)]
                  [cursor -600])
              (begin
                (for ([c centers])
                  (let ([gap-start cursor] 
                        [gap-end (- c (/ p-w 2))])
                    (begin
                      (when (> gap-end gap-start) 
                        (draw-gap dc gap-start gap-end y h))
                      (set! cursor (+ c (/ p-w 2))))))
                (when (< cursor 600) 
                  (draw-gap dc cursor 600 y h))))
            ;; Oletus jos ei tolppia
            (draw-gap dc -600 600 y h))))

    (define/private (draw-gap dc x1 x2 y h)
      (let ([gap-w (- x2 x1)])
        (when (> gap-w 1)
          (begin
            (send dc set-brush "white" 'transparent)
            (send dc set-pen "black" 1.0 'solid)
            (send dc draw-rectangle x1 y gap-w h)
            (draw-robust-zigzag dc x1 x2 y h)))))))

;; --- KERROSHALLINTA ---
(define layer%
  (class object% 
    (super-new)
    (init-field material w h y-offset [cc #f])
    (define/public (get-h) h)
    (define/public (calculate-weight)
      (send material calculate-weight-in-layer w h cc))
    (define/public (calculate-r-value)
      (let ([L (get-field lambda material)])
        (if (> L 0) (/ (/ h 1000.0) L) 0)))
    (define/public (render dc)
      (send material draw dc w h y-offset cc))))

;; --- RAKENNUSFYSIIKKA ---
(define (get-surface-resistance st)
  (let ([s (string-downcase (or st "ulkoseinä"))])
    (cond [(member s '("yläpohja" "up")) 0.14] [(member s '("alapohja" "ap")) 0.21] [else 0.17])))