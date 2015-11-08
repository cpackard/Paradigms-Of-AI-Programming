;; Exercises for chapter 3

;;
;; Exercise 3.1 [m]
;;
;; Show a lambda expression that is equivalent to the below let* expression.
;; You may need more than one lambda.
;;
;; (let* ((x 6)
;;        (y (* x x)))
;;   (+ x y) => 42
(defun sample-lambda-let ()
  ((lambda (x)
     ((lambda (x y) (+ x y))  x (* x x))) 
   6))

;;
;; Exercise 3.2 [s]
;;
;; The function cons can be seen as a special case of one of the other
;; functions listed previously. Which one?
;;
;; A: #'list

;;
;; Exercise 3.3 [m]
;;
;; Write a function that will print an expression in dotted pair notation.
;; Use the built-in function princ to print each component of the expression.

(defun print-dotted-pair (lst)
  (cond ((null lst)
         (princ '()))
        ((null (rest lst))
         (princ lst))
        (t
         )))

;;
;; Exercise 3.4 [m]
;;
;; Write a function that, like the regular print function, will print an expression
;; in dotted pair notation when necessary but will use normal list notation
;; when possible



;;
;; Exercise 3.5 [h]
;;
;; (Exercise in alternating structure) Write a program that will play the role of the
;; guesser in the game Twenty Questions. The user of the program will have in mind
;; any type of thing. The program will ask questions of the user,
;; which must be answered yes or no, or "it" when the program has guessed it.
;; If the program runs out of guesses, it gives up and asks the user what "it" was.
;; At first the program will not play well, but each time it plays, it will remember
;; the user's replies and use them for subsequent guesses.
