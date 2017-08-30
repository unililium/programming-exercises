#lang racket

(define (element-at L n)
  (if (= n 0)
      (car L)
      (element-at (cdr L) (- n 1))))

(define (range n m)
  (if (>= m n)
      (if (= n m)
          (cons n '())
          (cons n (range (+ n 1) m)))
      '()))