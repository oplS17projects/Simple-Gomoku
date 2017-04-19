#lang racket

;; works as a stub function ;;

(provide calc-black-stone)

(define list1 '((1 1) (1 2) (3 4) (5 6) (3 5))) ;; test list
(define list2 '((3 1) (10 2) (3 14) (9 6) (0 5))) ;; test list


(define (calc-black-stone placed-black-stones placed-white-stones)
  (define (check a b)
    (if (and (not (member (list a b) placed-black-stones))
             (not (member (list a b) placed-white-stones)))
        (list a b)
        (if (= a 14)
            (check 0 (+ b 1))
            (check (+ a 1) b))))
  (check 1 1)
)
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

