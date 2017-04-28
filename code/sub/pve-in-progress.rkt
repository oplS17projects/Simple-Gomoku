#lang racket

;; works as a stub function ;;

(provide calc-stone)

(define black_three_list '()) ;; store currect 
(define black_four_list '()) ;; store current

(define white_three_list '()) ;; store current
(define white_four_list '()) ;; store current
 

(define list1 '((1 1) (1 2) (3 4) (5 6) (3 5))) ;; test list
(define list2 '((3 1) (10 2) (3 14) (9 6) (0 5))) ;; test list


(define (calc-stone placed-black-stones placed-white-stones)

  
  (define (check-pos coord)
   (if(member coord placed-black-stones)
      1
      (if(member coord placed-white-stones)
         0
         'e)))
  (define (itr coord pos lst count)
   (let ((label (check-pos coord)))
     (if(count < 5)
        (if(eq? (pos coord) label)
          (itr (pos coord) pos (cons label lst) (+ count 1))
          (if (eq? (pos coord) 0)
              lst
              (if(eq? (pos coord) 'e)
                 (itr coord pos (cons 'e lst) (+ count 1))
                 lst)))
        lst)))
  ;;;;;;;;;
  ;;A B C;;
  ;;D 0 E;;
  ;;F G H;; 
  ;;;;;;;;;
  
  (define (find-optimal a b label) ;; (a b) has to be 1 or 0 ;; apply to existing black stone ;; returns
    
  ;; check A H
  ;; check D E
  ;; check F C
  ;; check B G

    (let ((A (pos-A a b))
          (B (pos-B a b))
          (C (pos-C a b))
          (D (pos-D a b))
          (E (pos-E a b))
          (F (pos-F a b))
          (G (pos-G a b))
          (H (pos-H a b)))
      (let ((toA (itr A pos-A '() 0))
            (toH (itr H pos-H '() 0))
            (toD (itr D pos-D '() 0))
            (toE (itr E pos-E '() 0))
            (toF (itr F pos-F '() 0))
            (toC (itr C pos-C '() 0))
            (toB (itr B pos-B '() 0))
            (toG (itr G pos-G '() 0)))
             (if (> (+ (length toA) (length toH)) 4)
            )
        
        )
         
    
 
  ))


  (define (pos-A a b) (if((outoffbound? (- a 1) (- b 1)))
                         #f
                         (list (- a 1) (- b 1))))

  (define (pos-B a b) (if((outoffbound? a (- b 1)))
                         #f
                         (list a (- b 1))))

  (define (pos-C a b) (if((outoffbound? (+ a 1) (- b 1)))
                         #f
                         (list (+ a 1) (- b 1))))

  (define (pos-D a b) (if((outoffbound? (- a 1) b))
                         #f
                         (list (- a 1) b)))

  (define (pos-E a b) (if((outoffbound? (+ a 1) b))
                         #f
                         (list (+ a 1) b)))

  (define (pos-F a b) (if((outoffbound? (- a 1) (+ b 1)))
                         #f
                         (list (- a 1) (+ b 1))))

  (define (pos-G a b) (if((outoffbound? a (+ b 1)))
                         #f
                         (list a (+ b 1))))

  (define (pos-H a b) (if((outoffbound? (+ a 1) (+ b 1)))
                         #f
                         (list (+ a 1) (+ b 1))))

  (define (outoffbound? a b)
    (if (or (> a 14) (< a 0) (> b 14) (< b 0))
        #t
        #f))

  (define (pos-x a b)
  (if((outoffbound? a b))
     #f
     (check-pos a b)))

  (define (evaluate coord)
  (if(eq? 'e (check-pos coord))
     '()
     0)
  )

  
  (define (check a b)
    (if (and (not (member (list a b) placed-black-stones))
             (not (member (list a b) placed-white-stones)))
        (list a b)
        (if (= a 14)
            (check 0 (+ b 1))
            (check (+ a 1) b))))
  (check 1 1)
)




;; label either 0 - white
;;              1 - black
;;              'e - empty

;; trace 5



;; testing procedure which will always place black-piece to 1 1

;; list all the threats
;; creating fork
;; 2 - fours
;; 1 four and one opened three
;; list all the threats
;;
;; evaluate each piece based on.... 
;; must wins: 
;; store opened 3-stone 's
;; store opened/ one-ended 4-stones

;; block opponent's 4 stones, opened 3 stones
;;
;; find forking opportunities
;; 