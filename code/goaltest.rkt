#lang racket

;; goal tests
;;
;; 4/7/2017
;;
;; Xiaoling Zheng
;;
;; check horizontal
;; get all x-coords
;; for each x-coords get all y-coords with certain x
;; check if contains consecutive 5
;;
;; check vertical
;; get all y-coords
;; for each y-coords get all x-coords with certain y
;; check if contains consecutive 5
;;

(provide goal-test?)

(define (goal-test? coord-list)
  (or (check-vertical? coord-list)
      (check-horizontal? coord-list)
      (check-bottom-left-to-upper-right (sort-by-y-axis coord-list))
      (check-top-left-to-bottom-right (sort-by-x-axis coord-list))))

;; check-horizontal
(define (check-vertical? lst)
  (let ((x-axis (get-xs lst)))
    (foldr (lambda(x y) (or (consecutive-five? (y-coords-given-x x lst)) y)) #f
         x-axis)))
;; check-horizontal

;; check-vertical
(define (check-horizontal? lst)
  (let ((y-axis (get-ys lst)))
    (foldr (lambda(x y) (or (consecutive-five? (x-coords-given-y x lst)) y)) #f
         y-axis)))
;; check-vertical

;; check-cross
;;(define (check-cross? lst)
;;  )

;;(define check-list '())
;;(set! check-list goal-three)

(define (check-top-left-to-bottom-right lst)
  (cond[(eq? lst #t) #t]
       [(< (length lst) 5) #f]
       [else (check-top-left-to-bottom-right (check-one-coord (car lst) incre-x-y lst))]))


(define (check-bottom-left-to-upper-right lst)
  (cond[(eq? lst #t) #t]
       [(< (length lst) 5) #f]
       [else (check-top-left-to-bottom-right (check-one-coord (car lst) decre-x-incre-y lst))]))



;; top-left to bottom-right
(define (check-one-coord start proc lst)
  (let ((check-list lst))
    (define (help-itr start lst count)
      (set! check-list (remove start check-list))
      (cond [(eq? lst #f) check-list]
            [(> count 4) #t]
            [(= (length lst) 1) check-list]
            [else (help-itr (proc start) (member start lst) (+ count 1))]))
    (help-itr start lst 0)))
;; returns true if line-up 5 coords starting from start
;; returns the remaining list if false with checked coord removed
;; get-inspired by member function

(define (incre-x-y coord)
  (list (+ (car coord) 1) (+ (cadr coord) 1)))
;; helper for upper-left to bottom-right

(define (decre-x-incre-y coord)
  (list (- (car coord) 1) (+ (cadr coord) 1)))
;; helper for bottom-left to upper-right

;; check-cross

;; helper function for check upper left to bottom right
;;
 (define (sort-by-x-axis lst)
   (sort (sort lst #:key cadr <) #:key car <))
;;
;; > (sort-by-x-axis '((3 3) (1 1) (2 2)))
;; '((1 1) (2 2) (3 3))
;; helper function for check upper left to bottom right
;;
;; helper function for check bottom left to upper right
 (define (sort-by-y-axis lst)
   (sort (sort lst #:key cadr <) #:key car >))
;;
;;(sort-by-y-axis '((13 1)(14 0)(3 1) (14 2) (13 4) (8 9)))
;;'((14 0) (14 2) (13 1) (13 4) (8 9) (3 1))
;; helper function for check bottom left to upper right

;; get y-coord in list
(define (get-ys list)
  (sort (remove-duplicates (foldl (lambda (x y) (cons (cadr x) y)) '() list )) <))

;; get x-coords in list
(define (get-xs list)
  (sort (remove-duplicates (foldl (lambda (x y) (cons (car x) y)) '() list )) <))

;; y-coord-given-x == index
 (define (y-coords-given-x index lst)
   (foldl (lambda(x y) (cons (cadr x) y))
                '()
                (sort (filter
                 (lambda(x) (= index (car x)))
                 lst) #:key cadr >)))
;; testing
;;> (y-coords-given-x 1 goal-one)
;;'(2 3 4 5 6)

;; x-coord-given-y == index
 (define (x-coords-given-y index lst)
   (foldl (lambda(x y) (cons (car x) y))
                '()
                (sort (filter
                 (lambda(x) (= index (cadr x)))
                 lst) #:key car >)))
;; testing
;;> (x-coords-given-y 1 goal-two)
;; '(1 2 3 4 5)
 
;; test cases
(define five1 '(1 2 3 4 5)) ; #t
(define five2 '(1 3 4 5 6 7 8)) ; #t
(define five3 '(1 2 4 5)) ; #f
(define five4 '(1 2 4 6 7 8 9)) ; #f
;; test cases

;; a procedure to helper check if a list contains consecutive 5 numbers
(define (consecutive-five? lst)
   (if (< (length lst) 5)
       #f
       (helper-lst lst 0)))
;; a procedure to helper check if a list contains consecutive 5 numbers

(define (helper-lst lst index)
  (if (= index 4)
      #t
      (if (null? (cdr lst))
          #f
          (if(= (+ 1 (car lst)) (cadr lst))
             (helper-lst (cdr lst) (+ 1 index))
             (helper-lst (cdr lst) 0)))))
;; iteration procedure goes through the list

