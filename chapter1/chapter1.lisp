;; Define a verison of last-name that handles "Rex Morgan MD", 
;; "Morton Downey, Jr.", and whatever other cases you can think of.

(defparameter *last-name-titles* '(MD Jr.))

(defun last-names (name)
  (if (or (null name) (member (first name) *last-name-titles*))
      nil
      (let ((current-name (first name))
            (prev-name (last-names (rest name))))
        (if (null prev-name)
            current-name
            prev-name))))

;; 
;; Exercise 1.2 [m]
;;
;; Write a functio to exponentiate, or raise a number to an integer power.
;; For example: (power 3 2) = 3^2 = 9.

(defun power (base expt)
  (power-recursive base base expt))

(defun power-recursive (result base expt)
  (cond ((= 1 expt) result)
        ((= 0 expt) 1)
        (t (power-recursive (* result base) base (1- expt)))))

;;
;; Exercise 1.3 [m]
;;
;; Write a function that counts the number of atoms in an expression.
;; For example: (count-atoms '(a (b) c)) = 3. Notice that there is something of an
;; ambiguity in this: should (a nil c) count as three atoms, or as two, because
;; it is equivalent to (a () c)?

(defun count-atoms (lst)
  (cond ((null lst) 0)
        ((listp (first lst)) (+ (count-atoms (first lst)) (count-atoms (rest lst))))
        ((atom (first lst)) (+ 1 (count-atoms (rest lst))))
        (t (count-atoms (rest lst)))))

;;
;; Exercise 1.4 [m]
;;
;; Write a function that counts the number of times an expression occurs anywhere
;; within another expression.
;; Example: (count-anywhere 'a '(a ((a) b) a)) => 3.

(defun count-anywhere (expr lst)
  (cond ((null lst) 0)
        ((listp (first lst)) 
         (+ (count-anywhere expr (first lst)) (count-anywhere expr (rest lst))))
        ((equal expr (first lst)) (+ 1 (count-anywhere expr (rest lst))))
        (t (count-anywhere expr (rest lst)))))

;;
;; Exercise 1.5 [m]
;;
;; Write a function to compute the dot product of two sequences of numbers,
;; represented as lists. The dot product is computed by multiplying corresponding
;; elements and then addng up the resulting products. Example:
;; (dot-product '(10 20) '(3 4)) = 10 x 3 + 20 x 4 = 110

(defun dot-product (seq-1 seq-2)
  (if (not (= (length seq-1) (length seq-2)))
      (format t "ERROR: Please enter two sequences of the same length~%")
      (apply #'+ (mapcar #'* seq-1 seq-2))))
