; Find the square root of a number iteratively
(define (sqrt x)
  (sqrt-iter starting-guess x))

; What do you want the minimum different to be
(define goal 0.01)

; Give a starting value to guess from
(define starting-guess 1.0)

; The actual guess function
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

; Set a goal
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) goal))

; Improve the guess iteratively
(define (improve guess x)
  (average guess (/ x guess)))

; Just get the average
(define (average x y)
  (/ (+ x y) 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Cube root of a number iteratively
(define (cube-root x)
  (cube-root-iter starting-guess 0.0 x))

; The actual iterative computation of the cube root
(define (cube-root-iter guess previous-guess x)
  (if (good-enough-cube? guess previous-guess)
    guess
    (cube-root-iter (improve guess x)
                    guess
                    x)))

; Should I stop already?
(define (good-enough-cube? guess x)
  (< (abs (- guess x)) (abs (* guess goal)))) 

; I think I'm using too many comments
(define (improve guess x)
  (average3 (/ x (square guess)) guess guess))

(define (average3 a b c)
  (/ (+ a b c) 3))
