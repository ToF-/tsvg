; a turtle is 4 state: pen (up or down), coords (x,y) and heading (in degrees)

(defun make-turtle (pen coords heading)
  (cons pen (cons coords (cons heading ()))))

(defun new-turtle ()
  (make-turtle nil (quote (0.0 0.0)) 0.0))

(defun coords (turtle)
  (cadr turtle))

(defun pen-down? (turtle)
  (car turtle))

(defun heading (turtle)
    (caddr turtle))

(defun pen-down (turtle)
  (cons t (cdr turtle)))

(defun pen-up (turtle)
  (cons nil (cdr turtle)))

(defun x (turtle)
  (car (coords turtle)))

(defun y (turtle)
  (cadr (coords turtle)))

(defun move (distance coords heading)
  (let ((x (car coords))
        (y (cadr coords)))
    (cons
      (+ x (* distance (cos (/ (* heading pi) 180.0))))
      (cons
        (+ y (* distance (sin (/ (* heading pi) 180.0))))
        ()))))

(defun forward (distance turtle)
  (let ((pen (car turtle))
        (coords (cadr turtle))
        (heading (caddr turtle)))
    (make-turtle pen (move distance coords heading) heading)))

(defun right (angle turtle)
  (let ((pen (car turtle))
        (coords (cadr turtle))
        (heading (caddr turtle)))
    (make-turtle pen coords (- heading angle))))

(defun left (angle turtle)
  (let ((pen (car turtle))
        (coords (cadr turtle))
        (heading (caddr turtle)))
    (make-turtle pen coords (+ heading angle))))
