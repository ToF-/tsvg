(load "src/turtle")
(load "src/svg")

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

(defun rad-deg (r)
  (/ (* r 180.0) pi))

(defun calc-triangle (size adja)
  (let* ((adjb (sqrt (- (* size size) (* adja adja))))
         (theta (rad-deg (acos (/ adja size)))))
    (list adjb theta)))

(defun triangle (size turtle)
  (let* ((adja (* size 0.5))
         (calc (calc-triangle size adja))
         (adjb (car calc))
         (theta (cadr calc)))
    (execute `(
               (DOWN)
               (FORWARD ,size)
               (UP)
               (BACKWARD ,size)
               (DOWN)
               (RIGHT ,theta)
               (FORWARD ,adja)
               (LEFT 90)
               (FORWARD ,adjb)
               (UP)
               ) turtle)))

(defun main ()
    (let ((f-turtle (triangle 400.0 (square 400.0 (goto '(500.0 500.0) (new-turtle))))))
      (format t 
              (render-svg 1000 1000 (calibrate (lines f-turtle))))))

(main)
(sb-ext:quit)

