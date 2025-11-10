(require :asdf)
(load "src/turtle")
(load "src/svg")

(defun apply-rules (instruction)
    (cond ((eq 'X instruction) '(M Y F P X F X P F Y M))
          ((eq 'Y instruction) '(P X F M Y F Y M F X P))
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

