;; Exercises for chapter 2

(load "C:\\Users\\Christian\\Documents\\Paradigms_of_AI_Programming\\chapter2\\sentence_generator\\sentence_gen.lisp")

;;
;; Exercise 2.1 [m]
;;
;; Write a version of 'generate' that uses 'cond' but avoids calling 
;; 'rewrites' twice

(defun generate-let (phrase)
  "Generate a random sentence or phrase"
  (cond ((listp phrase)
         (mappend #'generate-let phrase))
        ((let ((current-rewrite (rewrites phrase)))
           (if current-rewrite
               (generate-let (random-elt current-rewrite)))))
        (t (list phrase))))

;;
;; Exercise 2.2 [m]
;;
;; Write a version of 'generate' that explicitly differentiates between
;; terminal symbols (those with no rewrite rules) and nonterminal symbols.

(defun generate-terminal (phrase)
  "Generate a random sentence or phrase"
  (cond ((listp phrase)
         (mappend #'generate-terminal phrase))
        ((non-terminal-p phrase)
         (generate-terminal (random-elt (rewrites phrase))))
        (t (list phrase))))

(defun non-terminal-p (category)
  "True if this is a category in the grammar"
  (not (null (rewrites category))))


;;
;; Exercise 2.3 [h]
;; 
;; Write a trivial grammar for some other language. This can be a
;; natural language other than English, or perhaps a subset of a 
;; computer language





;;
;; Exercise 2.4 [m]
;;
;; One way of describing 'combine-all' is that it calculates the 
;; cross-product of the function 'append' on the argument lists.
;; Write the higher-order function 'cross-product', and define 'combine-all'
;; in terms of it.
;; The moral is to make your code as general as possible, because
;; you never know what you may want to do with it next.
(defun cross-product (xlist ylist)
  (let ((x (apply #'append xlist))
        (y (apply #'append ylist)))
    (apply #'append (mapcar #'(lambda (y-elem)
                                (mapcar #'(lambda (x-elem) (list x-elem y-elem)) x))
                            y))))

(defun combine-all-2 (xlist ylist)
  "Returns a list of lists formed by appending a y to an x.
   E.g. (combine-all '((a) (b)) '((1) (2)))
   -> ((A 1) (B 1) (A 2) (B 2))."
  (cross-product xlist ylist))
