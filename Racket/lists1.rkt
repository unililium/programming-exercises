#lang racket

(define (my-last l)
   (if (null? (cdr l))
       (car l)
       (my-last (cdr l))))

(define (my-butlast l)
  (if (null? (cdr l))
      '()
      (if (null? (cddr l))
          (car l)
          (my-butlast (cdr l)))))

(define (element-at l n)
  (if (> n (length l))
      (printf "n gt length l")
      (if (= n 1)
          (car l)
          (element-at (cdr l) (- n 1)))))

(define (my-length l)
  (define (myl ll n)
    (if (null? (cdr ll))
        n
        (myl (cdr ll) (+ n 1))))
  (myl l 1))