(define (display-all . vs)
  (for-each display vs))

(define (assert a b)
  (cond ((equal? a b) #t) ; return #t for output brevity
	(else (display-all "test failed: " a " != " b) (error ""))))

(define (A a b) (assert a b))

(define (identity x) x)

(define (average x y)
  (/ (+ x y) 2))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (cube x) (* x x x))

(define (inc n) (+ n 1))

(define (dec n) (- n 1))

(define (divides? a b)
  (= (remainder b a) 0))

(define (next n)
  (+ n 1))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (prime? n)
  (and (> n 1) (= n (smallest-divisor n))))

(define nil '())

(define *op-table* (make-hash-table))

(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))

(define (get op type)
  (hash-table/get *op-table* (list op type) #f))
