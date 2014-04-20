(define (factorial1 n)
  (if (= 1 n)
    1
    (* n (factorial1 (- n 1)))))

; Block structure & tail recursiveness
; Matters because tail call optimisation implementation
; Recursive procedure that uses an iteration process
(define (factorial2 n)
  (define (factorial1-iter a b n)
    (if (= (- b 1) n)
      a
      (factorial2-iter (* a b) (+ b 1) n)))

  ; Make the call
  (factorial2-iter 1 1 n))
