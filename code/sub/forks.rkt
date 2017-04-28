#lang racket

;; in progress

;; find matching patterns - forks
;; return list of winning pos
;; class the provide procedures to extract patterns and find fork

;; 01110
;; find consecutive-3
;; pre & post not in opponent-lst - return pre

;;(define sort-three lst opponent-lst)
  
;; 01111
;; find consecutive-4
;; pre not in opponent-lst

;; return pre
;;(define four-1 lst opponent-lst)
  
;; 10111
;; find consecutive-3
;; pre not in opponent lst
;; pre^2 in lst

;; return pre
;;(define four-2 lst opponent-lst)

;; 11011
;; find consecutive-2
;; post not in opponent lst
;; post^2 & post^3 in list

;; return post
;;(define four-3 lst opponent-lst)

;; 11101
;; find consecutive 3
;; post not in opponent list
;; post^2 in lst

;; return post
;;(define four-4 lst opponent-lst)


;; 11110
;; find consecutive 4
;; post not in opponent list
;; return post
;;(define four-5 lst opponent-lst)



;; a procedure to helper check if a list contains consecutive 5 numbers
(define (consecutive-five? lst)
   (if (< (length lst) 5)
       #f
       (helper-lst lst 0 4)))

(define (consecutive-four? lst)
   (if (< (length lst) 4)
       #f
       (helper-lst lst 0 3)))

(define (consecutive-three? lst)
   (if (< (length lst) 3)
       #f
       (helper-lst lst 0 2)))

;; a procedure to helper check if a list contains consecutive 5 numbers

(define (helper-lst lst index consec-num)
  (if (= index consec-num)
      #t
      (if (null? (cdr lst))
          #f
          (if(= (+ 1 (car lst)) (cadr lst))
             (helper-lst (cdr lst) (+ 1 index) consec-num)
             (helper-lst (cdr lst) 0 consec-num)))))
;; iteration procedure goes through the list


