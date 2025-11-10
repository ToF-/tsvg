(require :asdf)
(load "src/turtle")
(load "src/svg")

(defparameter distance 5)
(defparameter angle 90)

(defun apply-rules (instruction)
    (cond ((eq 'F instruction) '(F P F M F M F P F P F M))
          (t (list instruction))))

(defun process-instructions (instructions)
  (cond ((null instructions) ())
        (t (append
             (apply-rules (car instructions))
             (process-instructions (cdr instructions))))))

(defun l-system (level instructions)
  (cond ((eq level 0) instructions)
        (t (let ((result (process-instructions instructions)))
             (l-system (- level 1) result)))))


(defun process (instructions turtle)
  (cond ((null instructions) turtle)
        ((eq 'F (car instructions)) (process (cdr instructions) (forward distance turtle)))
        ((eq 'P (car instructions)) (process (cdr instructions) (right angle turtle)))
        ((eq 'M (car instructions)) (process (cdr instructions) (left angle turtle)))
        (t (process (cdr instructions) turtle))))


(defun simple ()
  (let ((f-turtle
          (process
            (l-system 4 '(F P F P F P F))
            (down (goto '(30 -55) (new-turtle))))))
    (format t
            (render-svg 1000 1000 (calibrate (lines f-turtle))))))

(simple)
(sb-ext:quit)
