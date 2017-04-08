#lang racket
(require "classes.rkt")
(provide make-game)

(define (make-game)
  (let (( G (make-object game%)))
    (define (dispatch m)
      (cond[(equal? m 'occupied?) (lambda (x y) (send G check-occupancy x y))] 
           [(equal? m 'set-white) (lambda (x y) (send G set-white x y))] ;; returns #t if black stone wins
           [(equal? m 'set-black) (lambda (x y) (send G set-black x y))] ;; returns #t if white stone wins
           [(equal? m 'get-black-list) (send G black-list)] ;; return list of placed black stones
           [(equal? m 'get-white-list) (send G white-list)] ;; return list of placed whtie stones
           [(equal? m 'count?) (get-field count G)])) ;; return # of placed stones
    dispatch))
