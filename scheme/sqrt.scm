; Find the square root of a number iteratively
(define (sqrt x)
  (sqrt-iter 1.0 x)) ; start with a gues of 1

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

; Set a goal
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.01))

; Improve the guess iteratively
(define (improve guess x)
  (average guess (/ x guess)))

; Just get the average
(define (average x y)
  (/ (+ x y) 2))
