#lang racket
;;last modified Apr-09-2017 10:00 pm
(require racket/gui/base)
(require pict images/icons/control images/icons/style)
(require images/icons/symbol)
;;(require racket/draw)
;;(require images/icons/misc)
;;(require images/icons/stickman)
;;(require games/gl-board-game)
;;(require lang/posn htdp/draw)




;;xlz's exolire_gui_mouse_event 
(define msg1 (new message% [parent frame]
                          [label "(x-coord, y-coord)"]))


;;get the mouse block apr-7-2017
;;use get-x get-y to get x and y coords
;;later on replace 15 with (send event get-x)
(let ([x-coord 15])
  (if (= (remainder x-coord 4) 0)
      (let ([x-block (quotient x-coord 4)])
    x-block)
      (let ([x-block (+ 1 (quotient x-coord 4))])
    x-block)))

;;later on replace 1 with (send event get-y)
(let ([y-coord 1])
  (if (= (remainder y-coord 4) 0)
      (let ([y-block (quotient y-coord 4)])
    y-block)
      (let ([y-block (+ 1 (quotient y-coord 4))])
    y-block)))

;;decide the stone's color
;;user or boot who has black stones always go first
(define (stone-color steps)
  (if (= (remainder steps 2) 1)
  (let ([color 'black])
    color)
  (let ([color 'white])
    color)))

(require pict)
;;https://docs.racket-lang.org/pict/Basic_Pict_Constructors.html
;;new stones
;;because the previous stones would cause slow performance on my computer....



(record-icon #:color "Black" #:height 40
               #:material glass-icon-material)

(record-icon #:color "White" #:height 40
               #:material glass-icon-material)

(send frame show #t)

