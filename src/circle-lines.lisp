(load "src/turtle")
(load "src/svg")

(setf *random-state* (make-random-state t))

(defparameter trials 5000)
(defparameter width 1500)
(defparameter height 1500)
(defparameter radius (/ width 2.1))
(defparameter radius-sq (* radius radius))
(defparameter center-x (/ width 2.0))
(defparameter center-y (/ height 2.0))

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

(defun random-lines (n turtle)
  (if (eq 0 n)
    turtle
    (let* ((angle (random 360))
           (dist (random 100))
           (size (+ 5 (random 15)))
           (n-turtle (forward dist (turn angle turtle)))
           (coord-x (- (x n-turtle) center-x))
           (coord-y (- (y n-turtle) center-y))
           (d (+ (* coord-x coord-x) (* coord-y coord-y))))
      (cond
        ((> d radius-sq) (random-lines (- n 1) turtle))
        (t (random-lines (- n 1)
                         (square size
                                 (forward dist
                                          (turn angle turtle)))))))))
(defun main ()
  (let ((f-turtle
          (random-lines trials
                        (goto (list center-x center-y)
                              (new-turtle)))))
    (format t
            (render-svg width height (lines f-turtle)))))

(main)
(sb-ext:quit)
