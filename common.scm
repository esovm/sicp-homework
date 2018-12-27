; assert

(define (display-all . vs)
  (for-each display vs))

; display-all can be changed to error for debugging convenience
(define (assert exp act)
  (cond ((eq? exp act) #t)
	(else (display-all "assert failed: " exp " != " act) #f)))
