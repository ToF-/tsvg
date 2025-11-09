
(require :asdf)
(load "src/turtle")
(load "src/svg")

(defun star ()
  (let ((f-turtle
          (up (forward 500 (right 144 (forward 500 (right 144 (forward 500 (right 144 (forward 500 (right 144 (forward 500 (down (new-turtle))))))))))))))
    (format t
            (render-svg 1000 1000 (lines f-turtle)))))

(star)
(sb-ext:quit)
