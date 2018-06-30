Exercise 1.15.  The sine of an angle (specified in radians) can be computed by making use of the approximation sin(x) ~ x if x is sufficiently small, and the trigonometric identity <..> to reduce the size of the argument of sin. (For purposes of this exercise an angle is considered ``sufficiently small'' if its magnitude is not greater than 0.1 radians.) These ideas are incorporated in the following procedures:

(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
   (if (not (> (abs angle) 0.1))
       angle
       (p (sine (/ angle 3.0)))))

a.  How many times is the procedure p applied when (sine 12.15) is evaluated?

12.15 / 3^x < 0.1
3^x = 121.5
x = log(3, 121.5) ~ 4.37 => 5 times

(sine 12.15)
(p (sine 4.05))
(p (sine 1.35))
(p (sine 0.45))
(p (sine 0.15))
(p (sine 0.05))

b.  What is the order of growth in space and number of steps (as a function of a) used by the process generated by the sine procedure when (sine a) is evaluated?

time: O(log(n))
space: O(log(n))
