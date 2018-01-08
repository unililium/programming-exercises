#lang racket

(define (my-last l)
  (if (null? (cdr l))
      l
      (my-last (cdr l))))
(my-last '(a b c d))

(define (my-but-last l)
  (if (= 2 (length l))
      l
      (my-but-last (cdr l))))
(my-but-last '(a b c d))

(define (element-at l n)
  (if (= n 1)
      (car l)
      (element-at (cdr l) (sub1 n))))
(element-at '(a b c d) 3)

(define (my-length l)
  (define (lh l n)
    (if (null? l)
        n
        (lh (cdr l) (add1 n))))
  (lh l 0))
(my-length '(a b c d))

(define (my-reverse l)
  (if (null? (cdr l))
      l
      (append (my-reverse (cdr l)) (list (car l)))))
(my-reverse '(a b c d))