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
