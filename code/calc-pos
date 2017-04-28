#lang racket

;; calc the best place for AI to draw the stone
;; in progress

(provide calc-stone)

;;(define list1 '((1 1) (1 2) (3 4) (5 6) (3 5))) ;; test list
;;(define list2 '((3 1) (10 2) (3 14) (9 6) (0 5))) ;; test list

;;http://stackoverflow.com/questions/23133351/position-of-minimum-element-in-list
(define (min-position xs)
    (define (min-position2 count pos xs)
      (cond ((null? xs) #f)
            ((= 1 (length xs)) pos)
            ((< (car xs) (cadr xs))
             (min-position2 (+ count 1) pos (cons (car xs) (cddr xs))))
            (else (min-position2 0 (+ count pos 1) (cons (cadr xs) (cddr xs))))))
    (min-position2 0 0 xs))

;;stackoverflow ends

;;the function takes occupied black and white coordinates and the board's coordinates
(define (calc-stone placed-black-stones placed-white-stones board-coord)
  
  ;;list r represents all occupied blocks' coordinates
  (define r (list 'nil))
  (set! r (append placed-black-stones placed-white-stones))
  
  ;;list f represents all empty blocks' coordinates
  (define f (remove* r board-coord))
  
   ;;list z represents all empty blocks' coordinates except (7,7)
  (define c '(7 7))
  (define z (remove* c f))
  
  ;(define select-random
    ;(lambda (z)
      ;(let ((len (length z)))         
        ;(list-ref z (random len)))))
        
        ;;map the distance function to list z and calc the distance between all coords in z and (7,7)
  (define x (map (lambda (y)
                   (floor (sqrt
                    (+ (* (- (car y) 7) (- (car y) 7))
                     (* (- (cadr y) 7) (- (cadr y) 7))))))
                 z))
                 
      ;;find the closet empty block to (7,7)
  (list-ref z (min-position x))
  
  ;(select-random z)
  ;'(10 10)


  
  ;(sqrt (+ (* (- (car s) 7) (- (car s) 7)) (* (- (cadr s) 7) (- (car s) 7)))))
)
;(define s (select-random z))
;(list (car s) (cadr s))
;'(10 10)
  
   
;(define (check a b)
; (if (and (not (member (list a b) placed-black-stones))
;         (not (member (list a b) placed-white-stones)))
;   (list a b)
;  (if (= a 14)
;     (check 0 (+ b 1))
;    (check (+ a 1) b))))
  


;; testing procedure which will always place black-piece to 1 1

;; list all the threats
;; creating fork
;; 2 - fours
;; 1 four and one opened three
;; list all the threats
;;
;; evaluate each piece based on.... 
;; must wins: 
;; store opened 3-stone 's
;; store opened/ one-ended 4-stones

;; block opponent's 4 stones, opened 3 stones
;;
;; find forking opportunities
;; 

