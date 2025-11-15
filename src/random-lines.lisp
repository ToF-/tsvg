(load "src/turtle")
(load "src/svg")

(setf *random-state* (make-random-state t))

(defparameter width 1500)
(defparameter height 1500)

(defun random-lines (n turtle)
  (if (eq 0 n)
    turtle
    (let* ((angle (random 360))
           (dist (- (random 5) 25))
           (n-turtle (forward dist (turn angle turtle))))
      (cond
        ((< (x n-turtle) 0) (random-lines (- n 1) turtle))
        ((>= (x n-turtle) width) (random-lines (- n 1) turtle))
        ((< (y n-turtle) 0) (random-lines (- n 1) turtle))
        ((>= (y turtle) height) (random-lines (- n 1) turtle))
        (t (random-lines (- n 1)
                         (up
                           (forward dist
                                    (turn angle (down turtle))))))))))
(defun main ()
  (let ((f-turtle
          (random-lines 20000
                        (goto '(750.0 750.0)
                              (new-turtle)))))
    (format t
            (render-svg width height (lines f-turtle)))))

(main)
(sb-ext:quit)
