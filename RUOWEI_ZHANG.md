# Simple Gomoku via Sheme

## Ruowei Zhang
### April 30, 2017

# Overview
This set of code creates the Gomoku game. 

Gomoku is a popular board game, and the goal is to make five-in-a-row in either horizontal, vertical or diagnal direction.

Usually there are two players against each other. Players use mouse-click to draw black or white stones on the board.

The code has two main componets: GUI and Game Logic. 

The game has two modes: PVP and PVE.

**Authorship note:** All of the code described here was written by myself.

# Libraries Used
The code uses four libraries:
```
(require racket/gui)
(require racket/draw)
(require pict images/icons/control images/icons/style)
(require images/icons/symbol)
```

* The ```racket/gui``` library provides the ability to design all the game user interface (frame, canvas, button, mouse-events) and excute the call-back functions. It is one of the most important libraries for me to implement the game GUI.


* The ```racket/draw``` library is used to draw and redraw the canvas. It is also used in other small functions, for instance, change font, draw borders and the winning figures. 
* The ```pict images/icons/control images/icons/style``` library is used to design the texture of the stones.
*  The ```(require images/icons/symbol)``` library is used to design the texture of the buttons.

# Key Code Excerpts

Here is a discussion of the most essential procedures, including a description of how they embody ideas from 
UMass Lowell's COMP.3010 Organization of Programming languages course.

Five examples are shown and they are individually numbered. 

 
## 1. Using Object-Orientation to Design the GUI

I created several instances of multiple classes(frame/canvas) in ```racket/gui```.

I also used inheritance methods from the superclass. 

```
(define no-pen (new pen% [style 'transparent]))

(define no-brush (new brush% [style 'transparent]))
```

```
(define frame
      (new frame%
           [label "Simple Gomoku"]
           [width board-size]
           [height (+ board-size 132)]
           [style (list 'no-resize-border)]))
 ```
 
 ```
(define board%
   (class canvas%
   (inherit refresh-now)
   (inherit get-dc)
  ......))
````

```
(define board-canvas (new board%
    [parent frame]
   [min-width board-size]
   [min-height board-size]
   (paint-callback (lambda (canvas dc)
   .....))
```
I override ```on-event``` function and define the new behavior of this function.

It gets coordinates of the mouse-move and calculate which block the mouse is on.

```
 (define board%
    (class canvas%
        (inherit refresh-now)
        (inherit get-dc)
        (define board%
   
    (define/override (on-event event)
        (let 
        ((block-x (quotient (send event get-x) block-size)) 
        (block-y (quotient (send event get-y) block-size)))
          ......
```
      
 
## 2. Using State-Modification Approaches(Set!)

```set-pve``` code is in ```classes.rkt```, and it changes the game mode to PVE.

```reset-game``` was in the file, but we decided to use Xiaoling's version.

It is used to initialize or reinstated the game after clicking the 'New Game' button.


```
(define (reset-game)
      (begin
        (send game reset)
        (set! steps 0)
        (set! winner 0)
        (set! highlight-block null)))
```

It is used to change the game to PVE mode.

```
(define/public (set-pve t)
      (set! pve t))
```

## 3. Using Map and Filter(Remove*) with Data Abstraction

The code is in ```calc-stone.rkt ```. 

We use the data structure List to save three different kinds of coordinates.

This method ```calc-stone``` takes these different lists(black occupied list, white occupied list and the board list) as parameters.

```map``` and ```remove*``` are used to proccess the lists and return a selected coordinate to let the program draw the next black stone for PVE mode.


```
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
```


## 4. Dispatch

The code is in ```make-game.rkt```.

I added two more functions to Xiaoling's ```make-game.rkt``` using dispatch. 

It is used to call classes' own methods.

```
(define (make-game)
  (let (( G (make-object game%)))
    (define (dispatch m)
      (cond
      ......
      [(equal? m 'get-pve-pos?) (send G get-pve-pos)]
      [(equal? m 'reset) (send G reset)]
      ......))
      dispatch))
```

## 5. Using Functional Approaches in Many Functions

The following code is in ```main.rkt```.

Callback procedures for a button click using ```Begin``` and ```lambda expression```.

```
[callback (lambda (button event)
                     (begin
                       (send msg set-label "PVE Mode is chosen")
                       (reset-game)
                       ((game 'set-pve) #t)
                       ((game 'set-stone) 7 7)
                       (send board-canvas refresh-now)
                      ))]
 ```
 
 If the game is in PVE mode, the program will automatically calculate and draw the next black stone.
 This function used ```begin``` and ```let```.
 ```
 (if (eq? #t (game 'pve?))
        (begin 
        (let 
        ((new-stone (calc-stone (game 'get-black-list) (game 'get-white-list) board-coord)))
        ((game 'set-stone) (car new-stone) (cadr new-stone))))
    void)
```
 
 

