#lang racket
(require racket/draw racket/class)
(provide (all-defined-out))

(define material-base%
  (class object% (super-new)
    (init-field id name-fi color lambda)
    (define/public (draw dc w h y)
      (send dc set-brush color 'solid)
      (send dc set-pen "black" 1 'solid)
      (send dc draw-rectangle (- (/ w 2)) y w h))))

(define eriste%
  (class material-base% (super-new)
    (define/override (draw dc w h y)
      (super draw dc w h y)
      (send dc set-pen "black" 0.5 'solid)
      (let ([step (max 20 (/ h 1.5))])
        (for ([i (in-range 0 w step)])
          (let ([x1 (+ (- (/ w 2)) i)] [x2 (+ (- (/ w 2)) i (/ step 2))])
            (send dc draw-line x1 y x2 (+ y h))
            (send dc draw-line x2 (+ y h) (+ x1 step) y)))))))

(define puu%
  (class material-base% (super-new)
    (define/override (draw dc w h y)
      (super draw dc w h y)
      (send dc set-pen "black" 1 'solid)
      (send dc draw-line (- (/ w 2)) y (/ w 2) (+ y h))
      (send dc draw-line (/ w 2) y (- (/ w 2)) (+ y h)))))

(define ontelo%
  (class material-base% (super-new)
    (define/override (draw dc w h y)
      (super draw dc w h y)
      (send dc set-brush "white" 'solid)
      (for ([i (in-range 40 w 180)])
        (send dc draw-ellipse (+ (- (/ w 2)) i) (+ y (* h 0.2)) 100 (* h 0.6))))))

(define piste-base%
  (class material-base% (super-new)
    (define/override (draw dc w h y)
      (super draw dc w h y)
      (for ([i 40])
        (send dc draw-point (+ (- (/ w 2)) (random (exact-round w))) (+ y (random (exact-round h))))))))

(define layer%
  (class object% (super-new)
    (init-field material w h y-offset)
    (define/public (render dc) (send material draw dc w h y-offset))))