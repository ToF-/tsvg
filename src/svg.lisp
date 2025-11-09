(defun render-point (point)
  (format nil "~A,~A" (car point) (cadr point)))

(defun intersperse-strings (items)
  (cond
    ((null items) "")
    ((eq 1 (length items)) (car items))
    (t (concatenate 'string
                    (car items)
                    " "
                    (intersperse-strings (cdr items))))))

(defun render-polyline (points)
  (concatenate 'string
               "<polyline points=\""
               (intersperse-strings (mapcar #'render-point points))
               "\">"))

(defun render-polylines (lines)
  (cond
    ((null lines) "")
    (t (concatenate 'string
                    (format nil "~A~%" (render-polyline (car lines)))
                    (render-polylines (cdr lines))))))

(defun render-svg (width height lines)
  (concatenate 'string
               (format nil "svg height=\"~A\" width=\"~A\" xmlns=\"http://www.w3.org/2000/svg\">~%" height width)
               (render-polylines lines)
               "</svg>"))
