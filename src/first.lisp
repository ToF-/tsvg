(load "src/turtle")
(defun render (width height)
  (progn
    (format t
            "<svg width=\"~A\" height=\"~A\" xmlns=\"http://www.w3.org/2000/svg\">"
            width height)
    (format t 
            "<polyline points=\"0,0 0,150, 150,150, 150,0 0,0\"
  style=\"fill:none;stroke:black;stroke-width:1\" />")
  ))

(render 1000 1000)
(sb-ext:quit)
