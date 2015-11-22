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
  (print-dotted-pair-iter lst 0))

(defun print-dotted-pair-iter (lst count)
  (cond ((null lst)
         (princ '()))
        ((null (rest lst))
         (princ lst)
         ; close out the remaining parentheses
         (dotimes (x count)
           (princ ")")))
        (t
         (princ "(") 
         ; check if we need to recurse
         (if (consp (first lst))
             (print-dotted-pair-iter (first lst) 0)
             (princ (first lst)))
         (princ " . ") 
         (print-dotted-pair-iter (rest lst) (1+ count)))))

;; This version is cleaner, but much less efficient
(defun clean-print-dotted-pair (Lst)
  (let ((elem-last (last lst))
        (lst-no-last (butlast lst)))
    (mapc #'(lambda (x)
              (if (consp x)
                  (progn
                    (better-print x) (princ " . "))
                  (progn
                    (princ "(") (princ x) (princ " . "))))
          lst-no-last)
    (princ elem-last)
    (dotimes (x (1- (length lst)))
      (princ ")"))))

;;
;; Exercise 3.4 [m]
;;
;; Write a function that, like the regular print function, will print an expression
;; in dotted pair notation when necessary but will use normal list notation
;; when possible

(defun print-normal (lst)
  (cond ((null lst)
         (princ '()))
        ((null (rest lst))
         (princ lst))
        (t
         (let ((elem (first lst))
               (next-lst (rest lst)))
           (princ "(")
           (dotimes (x (length-dotted-pair lst)) 
             (cond ((not (listp next-lst)) ; dotted list
                    (princ elem) (princ " . ") (princ next-lst) (princ ")")
                    (return))
                   ; case where first element is also a list
                   ((listp elem)
                    (print-normal elem)
                    (if (null next-lst)
                        (princ ")")
                        (princ " ")))
                   ; end of list, terminate
                   ((null next-lst)
                    (princ elem) (princ ")"))
                   (t ; normal case
                    (princ elem ) (princ " ")))
             (setq elem (first next-lst))
             (setq next-lst (rest next-lst)))))))

(defun length-dotted-pair (lst)
  "Find the length of the input list, even if it has a dotted pair inside."
  (length-dotted-pair-iter lst 0))

(defun length-dotted-pair-iter (lst count)
  (cond ((null lst) count)
        ((not (listp lst)) (1+ count))
        (t
         (length-dotted-pair-iter (rest lst) (1+ count)))))

;; Exercise 3.5 [h]
;;
;; (Exercise in alternating structure) Write a program that will play the role of the
;; guesser in the game Twenty Questions. The user of the program will have in mind
;; any type of thing. The program will ask questions of the user,
;; which must be answered yes or no, or "it" when the program has guessed it.
;; If the program runs out of guesses, it gives up and asks the user what "it" was.
;; At first the program will not play well, but each time it plays, it will remember
;; the user's replies and use them for subsequent guesses.

;; See TwentyQuestions.lisp 


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

(defun find-all (item sequence &rest keyword-args
                                 &key (test #'eql) test-not &allow-other-keys)
  "Find all those elements of sequence that match item, according to keywords.
   Doesn't alter sequence."
  (if test-not
      (apply #'remove item sequence
             (append keyword-args (list :test-not (complement test-not))))
      (apply #'remove item sequence
             (append keyword-args (list :test (complement test))))))


;;
;; Exercise 3.9 [m]
;;
;; Write a version of length using the function 'reduce'

;; My version
;;
(defun length-reduce (lst)
  (if (null lst)
      0
      (let ((count 1))
        (reduce #'(lambda (x y) (setq count (1+ count))) lst))))

;; Answer in book 
(defun length-r (lst)
  (reduce #'+ lst :key #'(lambda (x) 1)))


;;
;; Exercise 3.10 [m]
;
;; Use a reference manual or 'describe' to figure out what the functions
;; 'lcm' and 'nreconc' do.

;; (documentation #'lcm 'function)
;; Returns the least common multiple of one or more integers.
;; LCM of no arguments is defined to be 1.

;; (documentation #'nreconc 'function)
;; Return (NCONC (NREVERSE X) Y)

;; (documentation #'nconc 'function)
;; Concatenates the lists given as arguments (by changing them)
;; (documentatio #'nreverse 'function)
;; Return a sequence of the same elements in reverse order; the argument is destroyed.

;; So an explicit definition of nreconc:
;; Reverses the first argument, concatenates it with the second argument, and returns 
;; that sequence. Alters the arguments.

;; 
;; Exercise 3.11 [m]
;;
;; There is a built-in Common Lisp function that, given a key, a value,
;; and an association list, returns a new association list that is extended
;; to include the key/value pair. What is the name of this function?

;; Answer: acons
;; (documentation #'acons 'function)
;; Construct a new alist by adding the pair (KEY . DATUM) to ALIST
;; (acons key datum alist) == (cons (cons key datum) alist)


;; Exercise 3.12 [m]
;;
;; Write a single expression using 'format' that will take a list of
;; words and print them as a sentence, with the first word capitalized
;; and a period after the last word. You will have to consult a 
;; reference to learn new format directives.

;; Book answer:
;; (format t "~@(~{~a~^ ~}.~)" '(this is a test))
