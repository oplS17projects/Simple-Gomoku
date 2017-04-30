#lang racket

;;This function will return a coordinate and the coordinate will be used in main.rkt. 
;;The program then will draw black stones in PVE mode.

(provide calc-stone)

;(define list1 '((1 1) (1 2) (3 4) (5 6) (3 5))) ;; test list
;(define list2 '((3 1) (10 2) (3 14) (9 6) (0 5))) ;; test list

;;Credit: http://stackoverflow.com/questions/23133351/position-of-minimum-element-in-list
(define (min-position xs)
    (define (min-position2 count pos xs)
      (cond ((null? xs) #f)
            ((= 1 (length xs)) pos)
            ((< (car xs) (cadr xs))
             (min-position2 (+ count 1) pos (cons (car xs) (cddr xs))))
            (else (min-position2 0 (+ count pos 1) (cons (cadr xs) (cddr xs))))))
    (min-position2 0 0 xs))

;;this function takes 3 parameters(black occupied list, white occupied list and the board list) and return a selected coordinate.

(define (calc-stone placed-black-stones placed-white-stones board-coord)
  
  (define occupiedlst (list 'nil))
  (set! occupiedlst (append placed-black-stones placed-white-stones))
  (define emptylst (remove* occupiedlst board-coord))
  (define center '(7 7))
  (define emptylst2 (remove* center emptylst))
  
  (define x (map (lambda (y)
                   (floor (sqrt
                    (+ (* (- (car y) 7) (- (car y) 7))
                     (* (- (cadr y) 7) (- (cadr y) 7))))))
                 emptylst2))
  (list-ref emptylst2 (min-position x))
)
  


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

