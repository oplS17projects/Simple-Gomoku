#lang racket

(require "access-game-info.rkt")
(require "calc-best-place-black-stone.rkt")

;; a game

(define pve 'ai) ;; we assume ai has black stones; it will always be player-one
(define pvp 'pvp) ;; two persons start from placing black stones; player-one, player-two, player-one, ...

(define (main mode)
  (let ((mode-select mode)
       (game (make-game))
       (result #f)) ;; represents no one wins will be updated after each set-piece
    
    (if (equal? pve 'ai)
        (pve #f)
        (pvp #f))
    
    (define (get-coord) (calc-black-stone (game 'get-black-list) (game 'get-white-list)))
    ;; call procedure calculate best coord to place black stone
    
    (define (pve status)
      (if (status)
          (win-prompt)
          (let ((coord (get-coord (game 'get-black-list) (game 'get-white-list))))
            (cond[(equal? (game 'set-black-piece (car coord) (cdr coord)) 'black) (set! result 'black)
                                                                                  (pve #t)]
                 [else '()]
                 ;;  [else (get white from input - coord)
                 ;;        (cond[(equal? (game 'set-white-piece (car coord) (cdr coord) 'white)(set! result 'white)
                 ;;                                                                             (pve #t)]
                 ;;             [else (pve #f)])])
               ))))

    (define (pvp status)
      (if (status)
          (win-prompt)
          (#f)
          ;; -- (get black piece from input)
          ;; -- (cond [(set black piece) == 'black) (set! result 'black)
          ;;                                        (pvp #t)]
          ;; --       [else (get white piece from input)
          ;;                (cond[(set white piece) == 'white) (set! result white)
          ;;                                                   (pvp #t)]
          ;;                     [else (pvp #f)])])
          ))
    
     (define (win-prompt)
       (display result))
            
     ;; if (equal? pve 'ai)
       ;; black - get-input (calc-black-stone (game 'get-black-list) (game 'get-white-list))- set-piece 
       ;; white - get-input - set-piece 
    ;; else 
       ;; calc-piece - set-piece 
       ;; white - get-input - set-piece
    )

 
