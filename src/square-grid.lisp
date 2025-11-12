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

(defun next-col (size turtle)
  (execute `((backward ,size)
             (right 90)
             (forward ,(/ size 16))
             (left 90)) turtle))


(defun square-grid (size)
  (let* ((section (/ size 16.0))
         (f-turtle
           (n-times
             16
             (lambda (turtle)
               (next-col size
                         (n-times
                           16 
                           (lambda (turtle)
                             (cross section
                                    (square section turtle)))
                           turtle)))
             (new-turtle))))
    (format t
            (render-svg 500 500 (lines f-turtle)))))

(square-grid initial-size)
(sb-ext:quit)
