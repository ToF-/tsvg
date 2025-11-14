; a turtle is 4 state: pen (up or down), coords (x,y) and head (in degrees)

(defun make-turtle (pen coords head trail stack)
  (cons pen (cons coords (cons head (cons trail (cons stack ()))))))

(defun new-turtle ()
  (make-turtle nil (quote (0.0 0.0)) 0.0 () ()))

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

(defun stack (turtle)
  (car (cddddr turtle)))

(defun down (turtle)
  (let ((coords (coords turtle))
        (head (head turtle))
        (trail (trail turtle))
        (stack (stack turtle)))
    (if (pen turtle)
      turtle
      (make-turtle t coords head
                   (cons '() trail)
                   stack))))

(defun up (turtle)
  (let ((coords (coords turtle))
        (head (head turtle))
        (trail (trail turtle))
        (stack (stack turtle)))
  (if (pen turtle)
    (make-turtle nil coords head
        (cons (cons coords (car trail)) (cdr trail))
        stack)
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

(defun goto (target turtle)
  (let ((pen (pen turtle))
        (coords (coords turtle))
        (head (head turtle))
        (trail (trail turtle))
        (stack (stack turtle)))
    (if pen
      (make-turtle
        pen
        target
        head
        (cons (cons coords (car trail)) (cdr trail))
        stack)
      (make-turtle
        pen
        target
        head
        trail
        stack))))

(defun forward (distance turtle)
  (let ((pen (pen turtle))
        (coords (coords turtle))
        (head (head turtle))
        (trail (trail turtle))
        (stack (stack turtle)))
    (if pen
      (make-turtle
        pen
        (move distance coords head)
        head
        (cons (cons coords (car trail)) (cdr trail))
        stack)
      (make-turtle
        pen
        (move distance coords head)
        head
        trail
        stack))))

(defun backward (distance turtle)
  (forward (- distance) turtle))

(defun mod-360 (angle)
  (cond ((< angle -360) (+ angle 360))
        ((> angle 360) (- angle 360))
        (t angle)))

(defun right (angle turtle)
  (let ((pen (pen turtle))
        (coords (coords turtle))
        (head (head turtle))
        (trail (trail turtle))
        (stack (stack turtle)))
    (make-turtle pen coords (mod-360 (- head angle)) trail stack)))

(defun turn (angle turtle)
  (let ((pen (pen turtle))
        (coords (coords turtle))
        (trail (trail turtle))
        (stack (stack turtle)))
    (make-turtle pen coords angle trail stack)))

(defun left (angle turtle)
  (let ((pen (pen turtle))
        (coords (coords turtle))
        (head (head turtle))
        (trail (trail turtle))
        (stack (stack turtle)))
    (make-turtle pen coords (mod-360 (+ head angle)) trail stack)))

(defun lines (turtle)
  (reverse (mapcar #'reverse (trail turtle))))

(defun push-state (turtle)
  (let ((pen (pen turtle))
        (coords (coords turtle))
        (head (head turtle))
        (trail (trail turtle))
        (stack (stack turtle)))
    (make-turtle pen coords head trail
                 (cons (list pen coords head) stack))))

(defun pop-state (turtle)
  (let* ((trail (trail turtle))
         (state (car (stack turtle)))
         (pen (car state))
         (coords (cadr state))
         (head (caddr state)))
    (make-turtle pen coords head trail (cdr (stack turtle)))))

(defun execute (instructions turtle)
  (cond
    ((null instructions) turtle)
    (t (let* ((instruction (car instructions))
              (command (car instruction))
              (param (cadr instruction))
              (next-turtle
                (cond
                  ((eq 'UP command) (up turtle))
                  ((eq 'DOWN command) (down turtle))
                  ((eq 'GOTO command) (goto param turtle))
                  ((eq 'TURN command) (turn param turtle))
                  ((eq 'FORWARD command) (forward param turtle))
                  ((eq 'BACKWARD command) (backward param turtle))
                  ((eq 'RIGHT command) (right param turtle))
                  ((eq 'LEFT command) (left param turtle))
                  ((eq 'RUN command) (funcall param turtle))
                  ((eq 'PUSH-STATE command) (push-state turtle))
                  ((eq 'POP-STATE command) (pop-state turtle))
                  (t turtle))))
         (execute (cdr instructions) next-turtle)))))

(defun turtle-symbol (turtle)
  (execute `((UP)
             (LEFT 90)
             (DOWN)
             (FORWARD 15)
             (RIGHT 135)
             (FORWARD ,(* 15 (sqrt 2.0)))
             (RIGHT 90)
             (FORWARD ,(* 15 (sqrt 2.0)))
             (RIGHT 135)
             (FORWARD 15)
             (LEFT 90)
             (UP)) turtle))

(defun n-times (n f turtle)
  (if (= 0 n)
    turtle
    (n-times (- n 1) f (funcall f turtle))))
