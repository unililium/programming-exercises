#lang racket

(define (my-last L)
  (if (null? L)
      '()
      (if (null? (cdr L))
          (list (car L))
          (my-last (cdr L)))))

(define (element-at L n)
  (if (= 1 n)
      (car L)
      (element-at (cdr L) (- n 1))))

(define (my-length L)
  (if (null? L)
      0
      (add1 (my-length (cdr L)))))

(define (my-reverse L)
  (foldl cons '() L))