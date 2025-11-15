(load "src/turtle")
(load "src/svg")

(setf *random-state* (make-random-state t))

(defparameter width 1500)
(defparameter height 1500)
(defparameter square-size 100)

(defun square (size turtle)
    (execute `(
               (DOWN)
               (FORWARD ,size)
               (RIGHT 90)
               (FORWARD ,size)
               (RIGHT 90)
               (FORWARD ,size)
               (RIGHT 90)
               (FORWARD ,size)
               (RIGHT 90)
               (UP)
               ) turtle))

(defun random-squares (n turtle)
  (if (eq 0 n)
    turtle
    (let* ((angle (random 360))
           (factor (* 0.5 (+ (random 3) 1)))
           (dist (* factor (- (random 5) 25)))
           (size (+ 5 (random 15)))
           (n-turtle (forward dist (turn angle turtle))))
      (cond
        ((< (x n-turtle) 0) (random-squares (- n 1) turtle))
        ((>= (x n-turtle) width) (random-squares (- n 1) turtle))
        ((< (y n-turtle) 0) (random-squares (- n 1) turtle))
        ((>= (y turtle) height) (random-squares (- n 1) turtle))
        (t (random-squares (- n 1)
                           (square size
                             (down
                               (forward dist
                                        (turn angle (up turtle)))))))))))
(defun main ()
  (let ((f-turtle
          (random-squares 2000
                        (goto '(750.0 750.0)
                              (new-turtle)))))
    (format t
            (render-svg width height (lines f-turtle)))))

(main)
(sb-ext:quit)
