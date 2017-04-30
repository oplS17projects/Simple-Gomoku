#lang racket

;; main
;; Apr-20-2017



(require racket/gui)
(require racket/draw)
(require pict images/icons/control images/icons/style)
(require images/icons/symbol)
(require pict images/icons/control images/icons/style)

(require "make-game.rkt")
(require "calc-stone.rkt")

;;color database
;;https://docs.racket-lang.org/draw/color-database___.html


(provide run-game)

;;create a 600x600 board
;;the board is 15x15
;;the block is 40x40
(define board-size 600)
(define block-size 40)
(define square-board-dimension 15)

(define no-pen (new pen% [style 'transparent]))

(define no-brush (new brush% [style 'transparent]))

(define black-stone-color (record-icon #:color "Black" #:height 32 #:material glass-icon-material)) ;; color of black stone
(define white-stone-color (record-icon #:color "White" #:height 32 #:material glass-icon-material)) ;; color of white stone

;;;;;;;;;;;;;;;;;;;;;a list of 255 coords;;;;;;;;;;;;;;;;;;;;
(define board-coord '((0 0) (1 0) (2 0) (3 0) (4 0) (5 0) (6 0) (7 0) (8 0) (9 0) (10 0) (11 0) (12 0) (13 0) (14 0)
                            (0 1) (1 1) (2 1) (3 1) (4 1) (5 1) (6 1) (7 1) (8 1) (9 1) (10 1) (11 1) (12 1) (13 1) (14 1)
                            (0 2) (1 2) (2 2) (3 2) (4 2) (5 2) (6 2) (7 2) (8 2) (9 2) (10 2) (11 2) (12 2) (13 2) (14 2)
                            (0 3) (1 3) (2 3) (3 3) (4 3) (5 3) (6 3) (7 3) (8 3) (9 3) (10 3) (11 3) (12 3) (13 3) (14 3)
                            (0 4) (1 4) (2 4) (3 4) (4 4) (5 4) (6 4) (7 4) (8 4) (9 4) (10 4) (11 4) (12 4) (13 4) (14 4)
                            (0 5) (1 5) (2 5) (3 5) (4 5) (5 5) (6 5) (7 5) (8 5) (9 5) (10 5) (11 5) (12 5) (13 5) (14 5)
                            (0 6) (1 6) (2 6) (3 6) (4 6) (5 6) (6 6) (7 6) (8 6) (9 6) (10 6) (11 6) (12 6) (13 6) (14 6)
                            (0 7) (1 7) (2 7) (3 7) (4 7) (5 7) (6 7) (7 7) (8 7) (9 7) (10 7) (11 7) (12 7) (13 7) (14 7)
                            (0 8) (1 8) (2 8) (3 8) (4 8) (5 8) (6 8) (7 8) (8 8) (9 8) (10 8) (11 8) (12 8) (13 8) (14 8)
                            (0 9) (1 9) (2 9) (3 9) (4 9) (5 9) (6 9) (7 9) (8 9) (9 9) (10 9) (11 9) (12 9) (13 9) (14 9)
                            (0 10) (1 10) (2 10) (3 10) (4 10) (5 10) (6 10) (7 10) (8 10) (9 10) (10 10) (11 10) (12 10) (13 10) (14 10)
                            (0 11) (1 11) (2 11) (3 11) (4 11) (5 11) (6 11) (7 11) (8 11) (9 11) (10 11) (11 11) (12 11) (13 11) (14 11)
                            (0 12) (1 12) (2 12) (3 12) (4 12) (5 12) (6 12) (7 12) (8 12) (9 12) (10 12) (11 12) (12 12) (13 12) (14 12)
                            (0 13) (1 13) (2 13) (3 13) (4 13) (5 13) (6 13) (7 13) (8 13) (9 13) (10 13) (11 13) (12 13) (13 13) (14 13)
                            (0 14) (1 14) (2 14) (3 14) (4 14) (5 14) (6 14) (7 14) (8 14) (9 14) (10 14) (11 14) (12 14) (13 14) (14 14)
                            ))



;;initial the game with steps 0 and no winner yet

(define (run-game)

  (let ((game (make-game)) 
        (highlight-block null))

    (define (reset-game)
      (game 'reset)
      (set! highlight-block null))
    
    ;;create the frame
    ;;https://docs.racket-lang.org/gui/frame_.html?q=frame
    ;;the buttons has board size: 132
    
    (define frame
      (new frame%
           [label "Simple Gomoku"]
           [width board-size]
           [height (+ board-size 132)]
           [style (list 'no-resize-border)]))

    (define board%
      (class canvas%
        (inherit refresh-now)
        (inherit get-dc)
        ;;create the blocks two-color-blocks altenately
        
        (define/public (draw-block x y)
          (begin
            (send (get-dc) set-pen no-pen)
            (if (even? (+ x y))
                (send (get-dc) set-brush "White" 'solid)
                (send (get-dc) set-brush "AntiqueWhite" 'solid))
            (send (get-dc) draw-rectangle
                  (* x block-size)
                  (* y block-size)
                  block-size
                  block-size)))

        (define/public (draw-stone x y color)
          (send (get-dc) draw-bitmap
                color ;; (cond(game 'occupied?) == 'black -> draw black
                ;; (game 'occupied?) == 'white -> draw black
                (+ (* x block-size) 4)
                (+ (* y block-size) 4)))
        ;;block-board
        (define/public (show-block-border x y)
          (begin
            (send (get-dc) set-pen "black" 3 'solid)
            (send (get-dc) set-brush no-brush)
            (send (get-dc) draw-rectangle
                  (* x block-size)
                  (* y block-size)
                  block-size
                  block-size)))

        ;; mouse event callback
        (define/override (on-event event)
          (let ((block-x (quotient (send event get-x) block-size))
                (block-y (quotient (send event get-y) block-size)))
            (cond
              ;; mouse-left-click
              ((eq? 'left-down (send event get-event-type))
               ;;if there is no winner, keep playing
               ;;else void(freeze)
               (if (equal? (game 'winner?) 'none)
                   (begin (if (equal? 'empty ((game 'occupied?) block-x block-y)) ;; if (isempty)
                              ((game 'set-stone) block-x block-y);; (set-stone)
                              void)
                          ;;PVE mode
                          ;;;;;;;;;;add the AI function here!!!!!!!!;;;;;;;;;;;;;;;;;;
                          (if (eq? #t (game 'pve?))
                              (begin 
                               ;;the AI function to calculate best place to draw the stone
                                (let ((new-stone (calc-stone (game 'get-black-list) (game 'get-white-list))))
                                     ((game 'set-stone) (car new-stone) (cadr new-stone))))
                              ;; new-stone calc-stone((game 'get-black-list) (game 'get-white-list))
                              void)
                          ;;step=count
                          ;;3 different cases. Black wins. White wins. Draw.
                          ;;Give a message to user to let the user click 'Reset' button.
                          (send msg set-label (string-append "Step: " (number->string (game 'count?))))
                          (cond [(= (game 'count?) 225)
                                 (send msg set-label (string-append "Draw: " (number->string (game 'count?))". Please Reset the Game"))]
                                [(equal? (game 'winner?) 'black)
                                 (send msg set-label (string-append "At step: " (number->string (game 'count?))". Please Reset the Game"))]
                                [(equal? (game 'winner?) 'white)
                                 (send msg set-label (string-append "At step: " (number->string (game 'count?))". Please Reset the Game"))])
                          (refresh-now))
                   void))
              ;; mouse-over
              ;;highlight the block
              ((eq? 'motion (send event get-event-type))
               (if (equal? (game 'winner?) 'none)
                   ((lambda (x y)
                      (if (not (eq? (list x y) highlight-block))
                          (begin (refresh-now)
                                 (show-block-border x y)
                                 (set! highlight-block (list x y)))
                          void))
                    block-x
                    block-y)
                   void)))))
        (super-new)))
    
   ;;draw image on the canvas
    (define board-canvas (new board%
                              [parent frame]
                              [min-width board-size]
                              [min-height board-size]
                              (paint-callback (lambda (canvas dc)
                                                (map (lambda (x)
                                                       (send canvas draw-block (car x) (cadr x)))
                                                     board-coord)
                                                
                                                (map (lambda (x)
                                                       (send canvas draw-stone (car x) (cadr x) black-stone-color))
                                                     (game 'get-black-list))
                                               
                                                (map (lambda (x)
                                                       (send canvas draw-stone (car x) (cadr x) white-stone-color))
                                                     (game 'get-white-list))
                                                
                                                (cond [(= (game 'count?) 225)
                                                       ;;draw.
                                                       (send dc draw-bitmap (read-bitmap "draw.png") 0 185)]
                                                      
                                                      [(equal? (game 'winner?) 'black)
                                                       ;;black wins
                                                       (send dc draw-bitmap (read-bitmap "black.png") 0 185)]
                                                      
                                                      [(equal? (game 'winner?) 'white)
                                                       ;;white wins
                                                       (send dc draw-bitmap (read-bitmap "white.png") 0 185)])
                                                ))))
    ;;the white and black stones
    ;;https://docs.racket-lang.org/pict/Basic_Pict_Constructors.html

    ;;create the buttons
    ;;https://docs.racket-lang.org/gui/button_.html

    ;;text icon
    ;;http://docs.racket-lang.org/images/Icons.html#%28part._.About_.These_.Icons%29

    ;;make font
    ;;http://docs.racket-lang.org/draw/Drawing_Functions.html#%28def._%28%28lib._racket%2Fdraw..rkt%29._make-font%29%29
    
    ;;make the buttons horizontally
    ;;pvp or pve
    ;;start or stop

    
    ;;mode-panel & start-stop panel
    (define msg-panel (new horizontal-panel% [parent frame]))

    ;;message when running
    (define msg (new message% [parent msg-panel] [label "Please Choose A Mode. The Default is PVP"]))

    (define mode-panel (new horizontal-panel% (parent frame)))

    ;;Create 3 buttons and their call-backs
    (new button% [parent mode-panel]
         [label (text-icon "PVP mode"
                           (make-font #:weight 'normal #:underlined? #f)
                           #:color "LavenderBlush" #:height 30)]
         ; Callback procedure for a button click:
         [callback (lambda (button event)
                     (begin
                       (send msg set-label "PVP Mode is chosen")
                       ((game 'set-pve) #f)))]
         [horiz-margin 50]
         [min-width 150])

    (new button% [parent mode-panel]
         [label (text-icon "PVE mode"
                           (make-font #:weight 'normal #:underlined? #f)
                           #:color "LavenderBlush" #:height 30)]
         ; Callback procedure for a button click:
         [callback (lambda (button event)
                     (begin
                       (send msg set-label "PVE Mode is chosen")
                       ((game 'set-pve) #t)
                       ;;always draw the first black stone on (7,7) if PVE button is clicked
                       ((game 'set-stone) 7 7)
                       ;;use refresh-now to make display 
                       (send board-canvas refresh-now)
                      ))]
         [horiz-margin 50]
         [min-width 150])

    (define start-stop-panel (new horizontal-panel% (parent frame)))

    ;(new button% [parent start-stop-panel]
         ;[label (text-icon "Start!"
                           ;(make-font #:weight 'normal #:underlined? #f)
                           ;#:color "PaleTurquoise" #:height 30)]
         ; Callback procedure for a button click:
         ;[callback (lambda (button event)
                     ;(send msg set-label "Gomoku Started"))])

    ;;callback for stop button
    (new button% [parent start-stop-panel]
         [label (text-icon "New Game"
                           (make-font #:weight 'normal #:underlined? #f)
                           #:color "PaleTurquoise" #:height 32)]
         ;; Callback procedure for a button click, reset the game.
         [callback (lambda (button event)
                     (begin
                       (reset-game)
                       (send msg set-label "Reset is done! The Default Mode is PVP")
                       (send board-canvas refresh-now)))]
         [horiz-margin 200]
         [min-width 150])
    
    (send frame show #t)))

(run-game)
