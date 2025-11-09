(require :asdf)
(load "src/turtle")
(load "src/svg")

(defun square ()
  (let ((f-turtle
          (up (forward 100 (right 90 (forward 100 (right 90 (forward 100 (right 90 (forward 100 (down (new-turtle))))))))))))
    (format t
            (render-svg 400 400 (lines f-turtle)))))

(square)
(sb-ext:quit)
