#lang racket

(require math/matrix)
(require racket/class)

(define square-board-dimension 15)
;; dimension of a gomoku board

(struct point (x y))

;; represent one point
;; call point(x y) to create a structure point
;; call point-x-coordinate to get x-coordinate
;; call point-y-coordinate to get y-coordinate

(define point-class%
  (class object%
    (init-field x-coord y-coord)
    (init-field (Point (point x-coord y-coord)))
    (init-field (occupancy 'empty))
    (define/public (black-point) (set! occupancy 'black))
    (define/public (white-point) (set! occupancy 'white))
    (super-new)))

;; I want a point also holds occupancy information so I created a point-class


(define (make-board x)
  (build-matrix x x (lambda (a b) (make-object point-class% a b))))
;; an updated make-board with point-class

(define board-class%
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


(define game-class%
  (class object%
    (init-field (Board (make-object board-class%)))
    (init-field (Black-points '())) ;; list of occupied black points initialized to null
    (init-field (White-points '())) ;; list of occupied white points initialized to null
    (define/public (check-occupancy x y)
      (send Board check-occupancy x y))
    (define/public (set-black x y) ;; public method both update board and add point to lists
      (send Board set-black x y) 
      (set! Black-points (cons (cons x y) Black-points)))
    (define/public (set-white x y) ;; public method both update board and add point to lists
      (send Board set-white x y)
      (set! White-points (cons (cons x y) White-points)))
    ;; .....
    ;; other methods to be added 
    ;; .....
    (super-new)))
;; then I created a game-class that holds a board, list of black-points and white-points that latter on will hold occupied coordinates
