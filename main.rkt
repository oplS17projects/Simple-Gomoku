#lang racket

(require "access-game-info.rkt")
(require "calc-best-place-black-stone.rkt")

;; a game

(define pve 'ai) ;; we assume ai has black stones; it will always be player-one
(define pvp 'pvp) ;; two persons start from placing black stones; player-one, player-two, player-one, ...

;;(define (main mode)
;;  (let ((mode-select mode)
;;       (game (make-game)))))
    ;; if (equal? pve 'ai)
       ;; black - get-input (calc-black-stone (game 'get-black-list) (game 'get-white-list))- set-piece 
       ;; white - get-input - set-piece 
    ;; else 
       ;; calc-piece - set-piece 
       ;; white - get-input - set-piece
    ))

 