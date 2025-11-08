; a turtle is 4 state: pen (up or down), coords (x,y) and heading (in degrees)

(defun new-turtle ()
  (cons nil (list '((0.0 0.0) 90.0))))

(defun pen-down? (turtle)
  (car turtle))

(defun pen-down (turtle)
  (cons t (cdr turtle)))

(defun pen-up (turtle)
  (cons nil (cdr turtle)))
