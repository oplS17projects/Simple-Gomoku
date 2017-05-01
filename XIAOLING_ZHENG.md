# Simple-Gomoku

## Xiaoling Zheng
### April 30, 2017

# Overview

This project implements a strategic board game Gomoku using Scheme. My and my partner used Dr.Racket and racket libraries to create interface and internal game structure. The game we created allows both PVP and PVE mode. However, the PVE mode only works as a concept due to time limit. 

I focused on internal game structure, two main parts I did was creating game classes and goal-test. Game classes are based on racket/class library, while goal-test used some techqniues from the OPL class. 

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
```
The ```goal-test?``` predicate is a procedure that returns ```#t``` if the coord-list consists of a connected-5 coords, ```#f``` if not. Inside the procedure, there are four seperate procedures inside or. They checked vertical, horizontal and diagonal accordingly, returns #t if either satisfy connected-5. 


## 2. Use of foldr, foldl and filter

As a continuation of the above demonstration, here is a demonstraction of ```check-vertal?```: 
```
;; check-vertical
(define (check-vertical? lst)
  (let ((x-axis (get-xs lst)))
    (foldr (lambda(x y) (or (consecutive-five? (y-coords-given-x x lst)) y)) #f
         x-axis)))
;; check-vertical
```
This procedure first use procedure ```(get-xs list)``` to get a list of ```x-axis``` in the ```lst```. Then use foldr to apply predicate ```consecutive-five?``` (which checks either a list contains consecutive 5 numbers or not) to all the lists with the same x-coords (given by procedure ```(y-coords-given-x x lst)```). folder returns ```#t``` if one of ```consecutive-five?``` pred returns ```#t```, else returns ```#f```.

Basically ```check-vertical?``` does ```consecutive-five?``` checks on each and every lines that has x-coords in the lst. 

Demonstration of (y-coords-given-x index lst):

```
 (define (y-coords-given-x index lst)
   (foldl (lambda(x y) (cons (cadr x) y))
                '()
                (sort (filter
                 (lambda(x) (= index (car x)))
                 lst) #:key cadr >)))
```

As mentioned before, ```(y-coords-given-x index lst)``` returns list of y-coords for a certain x-coord. This procedure used both filter (to filter all the (x-coord, y-coord) lists inside lst with x-coord equals to ```index```, the result only contains coords with designate x-coord (```index```)). 

It then used foldl to accumulate all the y-coords from the lists by using (cadr x) to extract y-coords, then returns to list for ```consecutive-five?``` test.

## 3. Iterative recursion

Here is a demonstratio of ```consecutive-five?``` test on lists of single integers.

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
The ```helper-lst``` procedure iterates through the list of inputs (list of y-coords or list of x-coords), use index to indicate the amount of consecutive numbers, returns #t if the index reaches 4, #f if it reaches end of the list. 


## 3. State modification (with iterative recursive and data abstraction)


Here is a demonstration of horizontal check: 
```
(define (check-bottom-left-to-upper-right lst)
  (cond[(eq? lst #t) #t]
       [(< (length lst) 5) #f]
       [else (check-top-left-to-bottom-right (check-one-coord (car lst) decre-x-incre-y lst))]))
```
A proc helper function used in both ```check-top-left-to-bottom-right ```and ```check-bottom-left-to-upper-right``` (diagonal check)
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
This procedure holds a state ```check-list``` and updates the list by removing the first element of the list inside the helper function help-itr. State modification is helpful in this procedure for the reason that I constructed this procedure similar to the idea of member function. It returns the remaining list (with out just checked coords) if checked coords does not satisfy connected 5, returns ```#t``` if else. The iterative horizontal check will either move forward (when returned ```lst``` is remaining list) or terminates (when returned ```lst``` is ```#t``` or less than 5). 

```help-itr``` is also iterative recursion, use an index count to hold the amount of consecutive number. 

Argument ```proc``` is used for getting the next diagonal coordinates for certain coordinate. ```decre-x-incre-y``` is used for ```check-bottom-left-to-upper-right```, as shown below, it works as data abstraction. 

```
(define (decre-x-incre-y coord)
  (list (- (car coord) 1) (+ (cadr coord) 1)))
```

## 4. Object Orientaion - use of dispatch

Even though the game classes are all based on racket/class. As we progress in implementing our code, we found it is cumbersome to use accessors provided by racket/class. We decided to create a dispatch as shown below. 

```
(define (make-game)
  (let (( G (make-object game%)))
    (define (dispatch m)
      (cond[(equal? m 'occupied?) (lambda (x y) (send G check-occupancy x y))] 
           [(equal? m 'set-white) (lambda (x y) (send G set-white x y))] ;; returns #t if black stone wins
           [(equal? m 'set-black) (lambda (x y) (send G set-black x y))] ;; returns #t if white stone wins
           [(equal? m 'get-black-list) (send G black-list)] ;; return list of placed black stones
           [(equal? m 'get-white-list) (send G white-list)] ;; return list of placed whtie stones
           [(equal? m 'count?) (get-field count G)] ;; return # of placed stones
           [(equal? m 'board-string) (get-field board-string G)]
           [(equal? m 'winner?) (get-field winner G)]
           [(equal? m 'pve?) (get-field pve G)]
           [(equal? m 'reset) (send G reset)]
           [(equal? m 'set-stone) (lambda (x y)((if(eq? (get-field winner G) 'none) (send G set-stone x y) #f)))]))
    dispatch))
```
By providing procedure ```make-game```, our main can create game object and manipuate all the state informations. 

