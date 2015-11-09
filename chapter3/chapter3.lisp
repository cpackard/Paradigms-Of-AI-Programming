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
;; Exercise 3.6 [s]
;;
;; Given the following initialization for the lexical variable 'a' and the
;; special variable *b*, what will be the value of the 'let' form?

;; (setf a 'global-a)
;; (defvar *b* 'global-b)
;; (defun fn () *b*)
;; (let ((a 'local-a)
;;       (*b* 'local-b))
;;   (list a *b* (fn) (symbol-value 'a) (symbol-value '*b*)))

;; A: the 'let' form will return a list of the following:
;; ('local-a 'local-b 'local-b 'local-b 'global-a 'global-b)

;; Real Answer:
;; (local-a local-b local-b global-a local-b)



;;
;; Exercise 3.7 [s]
;;
;; Why do you think the leftmost of two keys is the one that counts,
;; rather than the rightmost?

;; Since keywords can appear in any order in Common Lisp the language
;; designers had to think of some kind of common convention do resolve
;; disputes when more than one keyword of the same type appeared.
;; For this reason I think they simply chose the leftmost keyword to be
;; consistent with the Polish-prefix notation that is used in Common Lisp.
;; 
;; To that extent, they could just as easily have used the rightmost
;; keyword as the default.


;;
;; Exercise 3.8 [m]
;;
;; Some versions of Kyoto Common Lisp (KCL) have a bug wherein they use the
;; rightmost value when more than one keyword/value pair is specified
;; for the same keyword.
;; Change the definition of find-all so that it works in KCL.



;;
;; Exercise 3.9 [m]
;;
;; Write a version of length using the function 'reduce'

(defun length10 (lst)
  (reduce #'(lambda (elem) (count (list elem)))))

;;
;; Exercise 3.10 [m]
;
;; Use a reference manual or 'describe' to figure out what the functions
;; '?????' and 'nreconc' do.



;; 
;; Exercise 3.11 [m]
;;
;; There is a built-in Common Lisp function that, given a key, a value,
;; and an association list, returns a new association list that is extended
;; to include the key/value pair. What is the name of this function?



;;
;; Exercise 3.12 [m]
;;
;; Write a single expression using 'format' that will take a list of
;; words and print them as a sentence, with the first word capitalized
;; and a period after the last word. You will have to consult a 
;; reference to learn new format directives.
