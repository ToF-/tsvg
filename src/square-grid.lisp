(load "src/turtle")
(load "src/svg")



(defparameter initial-size 400)

(defun square (size turtle)
  (execute `((turn 90)
             (DOWN)
             (FORWARD ,size)
             (RIGHT 90)
             (FORWARD ,size)
             (RIGHT 90)
             (FORWARD ,size)
             (RIGHT 90)
             (FORWARD ,size)
             (RIGHT 90)
             (UP)) turtle))

(defun cross (size turtle)
  (execute `((turn 45)
             (DOWN)
             (FORWARD ,(* size (sqrt 2)))
             (UP)
             (BACKWARD ,(* size (sqrt 2)))
             (turn 0)
             (forward ,size)
             (left 135)
             (down)
             (forward ,(* size (sqrt 2)))
             (up)
             (right 45)) turtle))
             

(defun n-times (n f turtle)
  (if (eq 0 n)
    turtle
    (n-times (- n 1) f (apply f turtle))))

(defun square-grid (size)
  (let ((f-turtle
          (turtle-symbol
            (n-times
              16 
              (lambda (x)
                (cross 
                  (/ size 16)
                  (square (/ size 16) x)))
              (new-turtle)))))
    (format t
            (render-svg 500 500 (lines f-turtle)))))

(square-grid initial-size)
(sb-ext:quit)
