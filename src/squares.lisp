(require :asdf)
(load "src/turtle")
(load "src/svg")

(defparameter angle 0.5)
(defparameter sin-angle (sin (* (/ angle 180.0) pi)))

(defun walk (turtle len)
  (if (< len 0.5) 
    turtle
    (walk 
      (right (+ 90 angle) (forward len turtle))
      (- len (* len sin-angle)))))


(defun squares ()
  (let ((f-turtle (walk (down (new-turtle)) 1000)))
    (format t
            (render-svg 1000 1000 (lines f-turtle)))))

(squares)
(sb-ext:quit)
