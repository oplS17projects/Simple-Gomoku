#lang racket

(require "make-game.rkt")
(require "calc-best-place-black-stone.rkt")

;; game

(define pve 'ai) ;; we assume ai has black stones; it will always be player-one
(define pvp 'pvp) ;; two persons start from placing black stones; player-one, player-two, player-one, ...

(define (main mode)
  (let ((mode-select mode)
       (game (make-game))
       (result #f)) ;; represents no one wins will be updated after each set-piece
    
    (define (start)
      (if (equal? mode 'ai)
          (pve #f)
          (pvp #f)))
    
    (define (get-coord) (calc-black-stone (game 'get-black-list) (game 'get-white-list)))
    ;; call procedure calculate best coord to place black stone
    
    (define (pve status)
      (if (equal? status #t)
          (win-prompt)
          (let ((coord (get-coord (game 'get-black-list) (game 'get-white-list))))
            (cond[(equal? (game 'set-black-piece (car coord) (cdr coord)) 'black) (set! result 'black)
                                                                                  (pve #t)]
                 [else #f]
                 ;;  [else (get white from input - coord)
                 ;;        (cond[(equal? (game 'set-white-piece (car coord) (cdr coord) 'white)(set! result 'white)
                 ;;                                                                             (pve #t)]
                 ;;             [else (pve #f)])])
               ))))

    (define (pvp status)
      (if (equal? status #t)
          (win-prompt)
          #f))
          ;; -- (get black piece from input)
          ;; -- (cond [(set black piece) == 'black) (set! result 'black)
          ;;                                        (pvp #t)]
          ;; --       [else (get white piece from input)
          ;;                (cond[(set white piece) == 'white) (set! result white)
          ;;                                                   (pvp #t)]
          ;;                     [else (pvp #f)])])
          
    
     (define (win-prompt)
       (display result))
    start))

 
