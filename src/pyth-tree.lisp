(load "src/turtle")
(load "src/svg")
(setf *random-state* (make-random-state t))


(defun square (size angle turtle)
  (execute `(
             (TURN ,angle)
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

(defun rad-deg (r)
  (/ (* r 180.0) pi))

(defun calc-triangle (size adja)
  (let* ((adjb (sqrt (- (* size size) (* adja adja))))
         (theta (rad-deg (acos (/ adja size)))))
    (list adjb theta)))

(defun triangle (size angle turtle)
  (if (> size 10)
    (let* ((adja (+ (* (/ size 2.0) (sqrt 2.0)) (- (* size 0.4)) (random (* size 0.8))))
           (calc (calc-triangle size adja))
           (adjb (car calc))
           (theta (cadr calc)))
      (execute `(
                 (PUSH-STATE)
                 (DOWN)
                 (RIGHT ,theta)
                 (FORWARD ,adjb)
                 (RIGHT 90)
                 (FORWARD ,adja)
                 (UP)
                 (POP-STATE)
                 (RIGHT ,theta)
                 (LEFT 90)
                 (RUN ,(lambda (tu) (trunk adjb theta tu)))
                 ) turtle))
    turtle))

(defun trunk (size angle turtle)
  (progn
    (format t "(trunk ~A ~A ~A~%" size angle turtle)
    (triangle size angle (forward size (square size angle turtle)))))

(defun main ()
    (let ((f-turtle (trunk 400.0 90 (goto '(500.0 500.0) (new-turtle)))))
      (format t 
              (render-svg 1000 1000 (calibrate (lines f-turtle))))))

(main)
(sb-ext:quit)

