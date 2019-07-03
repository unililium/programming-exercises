#lang racket

(print "ciao")

(define (my-last l)
  (if (null? (cdr l))
      (car l)
      (my-last (cdr l))))

(define (my-last-but-1 l)
  (when (not (null? (cdr l)))
    (if (null? (cddr l))
        (car l)
        (my-last-but-1 (cdr l)))))

(define (kth-el n l)
  (if (null? (cdr l))
      (car l)
      (if (= n 0)
          (car l)
          (kth-el (- n 1) (cdr l)))))

(define fold-left
  (lambda (f nil xs)
    (if (null? xs)
        nil
        (fold-left f (f (car xs) nil) (cdr xs)))))

(define reverse
  (lambda (xs)
    (fold-left cons '() xs)))