; a turtle is 4 state: pen (up or down), coords (x,y) and heading (in degrees)

(defun make-turtle (pen coords heading trail)
  (cons pen (cons coords (cons heading (cons trail ())))))

(defun new-turtle ()
  (make-turtle nil (quote (0.0 0.0)) 0.0 ()))

(defun pen (turtle)
  (car turtle))

(defun coords (turtle)
  (cadr turtle))

(defun pen-down? (turtle)
  (car turtle))

(defun heading (turtle)
    (caddr turtle))

(defun trail (turtle)
  (cadddr turtle))

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
  (let ((pen (pen turtle))
        (coords (coords turtle))
        (heading (heading turtle))
        (trail (trail turtle)))
    (make-turtle pen (move distance coords heading) heading trail)))

(defun right (angle turtle)
  (let ((pen (pen turtle))
        (coords (coords turtle))
        (heading (heading turtle))
        (trail (trail turtle)))
    (make-turtle pen coords (- heading angle) trail)))

(defun left (angle turtle)
  (let ((pen (car turtle))
        (coords (cadr turtle))
        (heading (caddr turtle))
        (trail (cadddr turtle)))
    (make-turtle pen coords (+ heading angle) trail)))
