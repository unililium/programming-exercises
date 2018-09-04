#lang racket
(define (sos l)
  (define (rec l acc)
    (if (null? l)
        acc
        (let ([x (car l)]
              [xs (cdr l)])
          (rec xs (+ acc (* x x))))))
    (rec l 0))

(define (flatten l)
  (define (rec l acc)
    (if (null? l)
        acc
        (let ([x (car l)]
              [xs (cdr l)])
          (if (not (list? x))
              (rec xs (cons x acc))
              (rec xs (rec x acc))))))
  (reverse (rec l '())))     

(define (mytake l n)
  (if (or (null? l) (zero? n))
      '()
      (cons (car l) (take (cdr l) (- n 1)))))

(define (slice l s e)
  (if (zero? s)
      (mytake l e)
      (slice (cdr l) (- s 1) e)))

(define (remove-at l n)
  (let ([x (car l)]
        [xs (cdr l)])
    (if (zero? n)
        xs
        (cons x (remove-at xs (- n 1))))))

(define (repli l n)
  (define (repeat x m)
    (if (zero? m)
        '()
        (cons x (repeat x (- m 1)))))
  (if (null? l)
      l
      (append (repeat (car l) n) (repli (cdr l) n))))

(define (compress l)
  (cond ((null? l)
         '())
        ((null? (cdr l))
         l)
        ((eq? (car l) (cadr l))
          (compress (cdr l)))
        (else
         (cons (car l) (compress (cdr l))))))

(define-syntax-rule (swap x y)
  (let ([tmp x])
    (set! x y)
    (set! y tmp)))
          
      