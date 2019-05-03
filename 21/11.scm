; Exercise 2.11.  In passing, Ben also cryptically comments: ``By testing the signs of the endpoints of the intervals, it is possible to break mul-interval into nine cases, only one of which requires more than two multiplications.'' Rewrite this procedure using Ben's suggestion.

(load "10.scm")

(define (smart-mul-interval x y)
  (define ub upper-bound)
  (define lb lower-bound)
  (cond ((and (negative? x) (negative? y))
	 (make-interval (* (ub x) (ub y)) (* (lb x) (lb y))))
	((and (negative? x) (spans-zero? y))
	 (make-interval (* (lb x) (ub y)) (* (lb x) (lb y))))
	((and (negative? x) (positive? y))
	 (make-interval (* (lb x) (ub y)) (* (ub x) (lb y))))
	((and (spans-zero? x) (negative? y))
	 (make-interval (* (ub x) (lb y)) (* (lb x) (lb y))))
	((and (spans-zero? x) (spans-zero? y))
	 (let ((p1 (* (lb x) (lb y)))
	       (p2 (* (lb x) (ub y)))
	       (p3 (* (ub x) (lb y)))
	       (p4 (* (ub x) (ub y))))
	   (make-interval (min p2 p3) (max p1 p4))))
	((and (spans-zero? x) (positive? y))
	 (make-interval (* (lb x) (ub y)) (* (ub x) (ub y))))
	((and (positive? x) (negative? y))
	 (make-interval (* (ub x) (lb y)) (* (lb x) (ub y))))
	((and (positive? x) (spans-zero? y))
	 (make-interval (* (ub x) (lb y)) (* (ub x) (ub y))))
	((and (positive? x) (positive? y))
	 (make-interval (* (lb x) (lb y)) (* (ub x) (ub y))))
	(else (display-all "error in smart-mul-interval! " x " " y))))

; ensure that new function acts as old one
(define (compare-mul-funcs x y)
  (assert (mul-interval x y) (smart-mul-interval x y)))

(define neg (make-interval -2 -1))
(define nz (make-interval -2 0))
(define spans (make-interval -1 1))
(define zz (make-interval 0 0))
(define pz (make-interval 0 2))
(define pos (make-interval 1 2))

(define (compare-mul-funcs-test x)
  (compare-mul-funcs x neg)
  (compare-mul-funcs x nz)
  (compare-mul-funcs x spans)
  (compare-mul-funcs x zz)
  (compare-mul-funcs x pz)
  (compare-mul-funcs x pos))

; test all possible pairs of defined variables
(compare-mul-funcs-test neg)
(compare-mul-funcs-test nz)
(compare-mul-funcs-test spans)
(compare-mul-funcs-test zz)
(compare-mul-funcs-test pz)
(compare-mul-funcs-test pos)