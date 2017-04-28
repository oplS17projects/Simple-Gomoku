#lang racket

;; classes
;; Apr-16-2017
;; The purpose of writing this file is to create useful classes.
;; It inclues game, board, point(block+stone), and player classes.

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


;; there will be two players. either 2 people, or a person and a boot.
;; set-stone use count(step) to decides if the stone should
;; be black or white.
(define player%
  (class object%
    (init-field (points-occupied '()))
    (define/public (set-stone x y)
      (set! points-occupied (cons (list x y) points-occupied)))
    (super-new)))

(define player-one? 'Black)
(define player-two? 'White)


;; this class controls the game.
(define game%
  (class object%
    (init-field (Board (make-object board%))) 
    (init-field (board-string (make-string 225 #\e))) ;; a field holds board as a string  
    (init-field (PlayerOne (make-object player%))) ;; list of occupied black points initialized to null
    (init-field (PlayerTwo (make-object player%))) ;; list of occupied white points initialized to null
    (init-field (count 0))
    (init-field (winner 'none))
    (init-field (pve #f))
    
    (define/public (check-occupancy x y)
      (send Board check-occupancy x y))
    
    (define/public (set-black x y) ;; public method both update board and add point to lists
      (send Board set-black x y) 
      (send PlayerOne set-stone x y)
      (string-set! board-string (+ y (* x 15)) #\b)
      (set! count (+ count 1))
      (if (< count 9)
          #f
          (cond [(goal-test? (black-list)) (set! winner 'black)
                                           #t]
                [else #f])))
    
    (define/public (set-white x y) ;; public method both update board and add point to lists
      (send Board set-white x y)
      (send PlayerTwo set-stone x y)
      (string-set! board-string (+ y (* x 15)) #\w)
      (set! count (+ count 1))
      (if (< count 9)
          #f
          (cond [(goal-test? (white-list)) (set! winner 'white)
                                           #t]
                [else #f])))
    
    (define/public (black-list) (get-field points-occupied PlayerOne))
    (define/public (white-list) (get-field points-occupied PlayerTwo))

    ;;reset the game
    (define/public (reset)
      (set! count 0)
      (set! pve #f)
      (set! winner 'none)
      (set! board-string (make-string 225 #\e))
      (set! PlayerOne (make-object player%))
      (set! PlayerTwo (make-object player%))
      (set! Board (make-object board%)))
      
      
     ;;rz's version not used.;;
     ;; (define (reset)
     ;;(define (reset-block t)
     ;;(let ((x ((t 'get-x)))
          ;; (y ((t 'get-y)))
          ;;(set-stone (t 'set-stone)))
        ;;(set-stone '())))
        ;;(map reset-block blocks))
        ;;end
    
  ;;the set-stone function  
    (define/public (set-stone x y)
      (if (= (remainder count 2) 0)
          (set-black x y)
          (set-white x y)))
       
   ;;calc-black-stone
    (define/public (get-pve-pos)
      void
      )

    ;;set mode
    (define/public (set-pve t)
      (set! pve t)
      )
    
    (super-new)))
