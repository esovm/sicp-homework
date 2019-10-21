; Exercise 2.89.  Define procedures that implement the term-list representation described above as appropriate for dense polynomials.

(load "ch25_common.scm")

; representation of term list

; append coefficient from term to supplementary zeros and term-list
(define (adjoin-term term term-list)
  (define zeros-len
    (- (order term) (length term-list)))
  (define term-coeff (coeff term))
  (if (=zero? term-coeff)
      term-list
      (append (cons term-coeff
		    (make-list zeros-len 0))
	      term-list)))

; constructs new term based on information from term-list
(define (first-term term-list)
  (make-term (dec (length term-list))
	     (car term-list)))

; gradually cuts off leading zero members
(define (rest-terms term-list)
  (define rest (cdr term-list))
  (if (empty-termlist? rest)
      rest
      (if (=zero? (car rest))
	  (rest-terms rest)
	  rest)))

(define term-23 (make-term 2 3))
(define long-term-list (adjoin-term term-23
				    (adjoin-term term-01
						 (adjoin-term empty-term
							      (the-empty-termlist)))))

(assert (first-term long-term-list) term-23)
(assert (first-term (rest-terms long-term-list)) term-01)
(assert (empty-termlist? (rest-terms (rest-terms long-term-list))) #t)
