; Exercise 1.30.  The sum procedure above generates a linear recursion. The procedure can be rewritten so that the sum is performed iteratively. Show how to do this by filling in the missing expressions in the following definition: <...>

(load "ch13_common.scm")

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
	result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(assert (s-integral cube 0 1 100) 1/4)
(assert (s-integral cube 0 1 1000) 1/4)
