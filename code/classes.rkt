#lang racket

;; classes
;;
;; Xiaoling Zheng
;;
;; point (piece), board, game classes 
;; game class contains all the state variables, accessor $ mutator for state variables
;;

(require math/matrix)
(require racket/class)
(require "goaltest.rkt")

(provide game%)

(define square-board-dimension 15)
;; dimension of a gomoku board

(struct Point (x y))

;; represent one point
;; call point(x y) to create a structure point
;; call point-x-coordinate to get x-coordinate
;; call point-y-coordinate to get y-coordinate

(define point%
  (class object%
    (init-field x-coord y-coord)
    (init-field (point (Point x-coord y-coord)))
    (init-field (occupancy 'empty))
    (define/public (black-point) (set! occupancy 'black))
    (define/public (white-point) (set! occupancy 'white))
    (super-new)))

(define (make-board x)
  (build-matrix x x (lambda (a b) (make-object point% a b))))
;; an updated make-board with point-class

(define board%
  (class object%
    (init-field (Dimension square-board-dimension)) ;; dimension from input
    (init-field (BOARD (make-board square-board-dimension))) ;; set up square board with dimension
    (define/public (check-occupancy a b) ;; check occupancy for single point
      (get-field occupancy (matrix-ref BOARD a b)))
    (define/public (set-black a b) ;; set occupany to symbol black
      (send (matrix-ref BOARD a b) black-point))
    (define/public (set-white a b) ;; set occupany to symbol white
      (send (matrix-ref BOARD a b) white-point))
    (super-new)))
;; a new board-class with a board constructed by point-class

(define player%
  (class object%
    (init-field (points-occupied '()))
    (define/public (set-piece x y)
      (set! points-occupied (cons (list x y) points-occupied)))
    (super-new)))

(define player-one? 'Black)
(define player-two? 'White)


(define game%
  (class object%
    (init-field (Board (make-object board%))) ;; board holds 15 by 15 pieces
    (init-field (PlayerOne (make-object player%))) ;; player holds black stone
    (init-field (PlayerTwo (make-object player%))) ;; player holds white stone
    (init-field (count 0)) ;; counting pieces
    
    (define/public (check-occupancy x y)
      (send Board check-occupancy x y))
    
    (define/public (set-black x y) ;; public method both update board and add point to lists
      (send Board set-black x y) 
      (send PlayerOne set-piece x y)
      (set! count (+ count 1))
      (if (< count 9)
          #f
          (if (goal-test? (black-list)) #t #f))) ;; goal test if count > 9
    
    (define/public (set-white x y) ;; public method both update board and add point to lists
      (send Board set-white x y)
      (send PlayerTwo set-piece x y)
      (set! count (+ count 1))
      (if (< count 9)
          #f
          (if (goal-test? (white-list)) #t #f))) ;; goal test is count > 9
    
    (define/public (black-list) (get-field points-occupied PlayerOne)) ;; return list of placed black stone coords from object PlayerOne
    (define/public (white-list) (get-field points-occupied PlayerTwo)) ;; return list of placed white stone coords from object PlayerTwo
    
    (super-new)))
