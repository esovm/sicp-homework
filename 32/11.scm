; Exercise 3.11.  In section 3.2.3 we saw how the environment model described the behavior of procedures with local state. Now we have seen how internal definitions work. A typical message-passing procedure contains both of these aspects. Consider the bank account procedure of section 3.1.1. Show the environment structure generated by the sequence of interactions:

(load "ch32_common.scm")

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT" m))))
  dispatch)

; GLOBAL: make-account acc
; make-account -- parameters: balance; body: (define (withdraw amount)..., link: GLOBAL

(define acc (make-account 50))

; GLOBAL: make-account acc
; E1 | balance:50, withdraw, deposit, dispatch, link to GLOBAL
; make-account -- parameters: balance; body: (define (withdraw amount)..., link: GLOBAL
; acc -- parameters: m; body: (cond ((eq? m 'withdraw) withdraw)..., link: E1

(assert ((acc 'deposit) 40) 90)

; GLOBAL: make-account acc
; E1 | balance:50, withdraw, deposit, dispatch, link to GLOBAL
; E2 | m:'deposit, link to E1
; make-account -- parameters: balance; body: (define (withdraw amount)..., link: GLOBAL
; acc -- parameters: m; body: (cond ((eq? m 'withdraw) withdraw)..., link: E1

; GLOBAL: make-account acc
; E1 | balance:50, withdraw, deposit, dispatch, link to GLOBAL
; E2 | amount:40, link to E1
; make-account -- parameters: balance; body: (define (withdraw amount)..., link: GLOBAL
; acc -- parameters: m; body: (cond ((eq? m 'withdraw) withdraw)..., link: E1

; GLOBAL: make-account acc
; E1 | balance:90, withdraw, deposit, dispatch, link to GLOBAL
; make-account -- parameters: balance; body: (define (withdraw amount)..., link: GLOBAL
; acc -- parameters: m; body: (cond ((eq? m 'withdraw) withdraw)..., link: E1

(assert ((acc 'withdraw) 60) 30)

; GLOBAL: make-account acc
; E1 | balance:90, withdraw, deposit, dispatch, link to GLOBAL
; E2 | m:'withdraw, link to E1
; make-account -- parameters: balance; body: (define (withdraw amount)..., link: GLOBAL
; acc -- parameters: m; body: (cond ((eq? m 'withdraw) withdraw)..., link: E1

; GLOBAL: make-account acc
; E1 | balance:90, withdraw, deposit, dispatch, link to GLOBAL
; E2 | amount:60, link to E1
; make-account -- parameters: balance; body: (define (withdraw amount)..., link: GLOBAL
; acc -- parameters: m; body: (cond ((eq? m 'withdraw) withdraw)..., link: E1

; GLOBAL: make-account acc
; E1 | balance:30, withdraw, deposit, dispatch, link to GLOBAL
; make-account -- parameters: balance; body: (define (withdraw amount)..., link: GLOBAL
; acc -- parameters: m; body: (cond ((eq? m 'withdraw) withdraw)..., link: E1

; Where is the local state for acc kept?

; Local state for acc (i.e., balance variable) is kept in frame E1.

; Suppose we define another account. How are the local states for the two accounts kept distinct? Which parts of the environment structure are shared between acc and acc2?

(define acc2 (make-account 100))

; GLOBAL: make-account acc acc2
; E1 | balance:30, withdraw, deposit, dispatch, link to GLOBAL
; E2 | balance:100, withdraw, deposit, dispatch, link to GLOBAL
; make-account -- parameters: balance; body: (define (withdraw amount)..., link: GLOBAL
; acc -- parameters: m; body: (cond ((eq? m 'withdraw) withdraw)..., link: E1
; acc2 -- parameters: m; body: (cond ((eq? m 'withdraw) withdraw)..., link: E2

; Local states for the two accounts are kept distinct by keeping them in separate frames E1 and E2. Both of this frames have links to GLOBAL frame and contain definitions of withdraw, deposit, dispatch procedures, which can share code in some implementations.
