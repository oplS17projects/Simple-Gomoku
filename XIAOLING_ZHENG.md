# Simple-Gomoku

## Xiaoling Zheng
### April 30, 2017

# Overview


**Authorship note:** All of the code described here was written by myself.

# Libraries Used
The code uses four libraries:

```
(require racket/class)
(require math/matrix)
```

* The ```racket/class``` library provides class and object interface
* The ```math/matrix``` library is used to construct game board

# Key Code Excerpts

Here is a discussion of the most essential procedures, including a description of how they embody ideas from 
UMass Lowell's COMP.3010 Organization of Programming languages course.

## 1. Predicates using Procedural Abstraction

```
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
```
## 3. State modification, data abstraction, state modification
A proc helper function used in both check-top-left-to-bottom-right and check-bottom-left-to-upper-right

```
(define (check-one-coord start proc lst)
  (let ((check-list lst))
    (define (help-itr start lst count)
      (set! check-list (remove start check-list))
      (cond [(eq? lst #f) check-list]
            [(> count 4) #t]
            [(= (length lst) 1) check-list]
            [else (help-itr (proc start) (member start lst) (+ count 1))]))
    (help-itr start lst 0)))
    
```


## 2. Iterative recursion

The following code helps to check if a list contains consecutive 5 numbers. It's a sub function used for goal test after sorting x-coords or y-coords:

```
(define (consecutive-five? lst)
   (if (< (length lst) 5)
       #f
       (helper-lst lst 0)))

(define (helper-lst lst index)
  (if (= index 4)
      #t
      (if (null? (cdr lst))
          #f
          (if(= (+ 1 (car lst)) (cadr lst))
             (helper-lst (cdr lst) (+ 1 index))
             (helper-lst (cdr lst) 0)))))
 ```
 
The helper procedure uses index as an indicator to label amount of consecutive numbers in a list, returns #t if the index reaches 4. This is a simple methods, but is used for goal-test for vertical and horizontal).
 
## 5. 
 (define (x-coords-given-y index lst)
   (foldl (lambda(x y) (cons (car x) y))
                '()
                (sort (filter
                 (lambda(x) (= index (cadr x)))
                 lst) #:key car >)))
