; a turtle is 4 state: pen (up or down), coords (x,y) and head (in degrees)

(defun make-turtle (pen coords head trail)
  (cons pen (cons coords (cons head (cons trail ())))))

(defun new-turtle ()
  (make-turtle nil (quote (0.0 0.0)) 0.0 ()))

(defun pen (turtle)
  (car turtle))

(defun coords (turtle)
  (cadr turtle))

(defun pen-down? (turtle)
  (car turtle))

(defun head (turtle)
    (caddr turtle))

(defun trail (turtle)
  (cadddr turtle))

(defun down (turtle)
  (let ((coords (coords turtle))
        (head (head turtle))
        (trail (trail turtle)))
    (if (pen turtle)
      turtle
      (make-turtle t coords head
                   (cons '() trail)))))

(defun up (turtle)
  (let ((coords (coords turtle))
        (head (head turtle))
        (trail (trail turtle)))
  (if (pen turtle)
    (make-turtle nil coords head
        (cons (cons coords (car trail)) (cdr trail)))
    turtle)))

(defun x (turtle)
  (car (coords turtle)))

(defun y (turtle)
  (cadr (coords turtle)))

(defun move (distance coords head)
  (let ((x (car coords))
        (y (cadr coords)))
    (cons
      (+ x (* distance (cos (/ (* head pi) 180.0))))
      (cons
        (+ y (* distance (sin (/ (* head pi) 180.0))))
        ()))))

(defun forward (distance turtle)
  (let ((pen (pen turtle))
        (coords (coords turtle))
        (head (head turtle))
        (trail (trail turtle)))
    (if pen
      (make-turtle
        pen
        (move distance coords head)
        head
        (cons (cons coords (car trail)) (cdr trail)))
      (make-turtle
        pen
        (move distance coords head)
        head
        trail))))

(defun right (angle turtle)
  (let ((pen (pen turtle))
        (coords (coords turtle))
        (head (head turtle))
        (trail (trail turtle)))
    (make-turtle pen coords (- head angle) trail)))

(defun left (angle turtle)
  (let ((pen (car turtle))
        (coords (cadr turtle))
        (head (caddr turtle))
        (trail (cadddr turtle)))
    (make-turtle pen coords (+ head angle) trail)))

