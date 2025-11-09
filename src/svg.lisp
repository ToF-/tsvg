(defun render-point (point)
  (format nil "~5,2F, ~5,2F" (car point) (cadr point)))

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
               "\" "
               "style=\"stroke:black; fill:none\" "
               "/>"))

(defun render-polylines (lines)
  (cond
    ((null lines) "")
    (t (concatenate 'string
                    (format nil "~A~%" (render-polyline (car lines)))
                    (render-polylines (cdr lines))))))

(defun translate (offset coords)
  (cons (+ (car coords) (car offset))
        (cons (+ (cadr coords) (cadr offset))
              ())))

(defun translate-line (offset line)
  (if (null line)
    ()
    (cons (translate offset (car line)) (translate-line offset (cdr line)))))

(defun translate-lines (offset lines)
  (if (null lines)
    ()
    (cons (translate-line offset (car lines)) (translate-lines offset (cdr lines)))))


(defun all-v (f lines)
  (if (null lines)
    ()
    (append (mapcar f (car lines)) (all-v f (cdr lines)))))

(defun minimum (l)
  (cond ((null l) nil)
        ((null (cdr l)) (car l))
        (t (let ((head (car l))
                 (tail-min (minimum (cdr l))))
             (if (< head tail-min)
               head
               tail-min)))))

(defun calibrate (lines)
  (let* ((min-x (minimum (all-v #'car lines)))
         (min-y (minimum (all-v #'cadr lines)))
         (off-coords (cons (- min-x) (cons (- min-y) ()))))
    (translate-lines off-coords lines)))

(defun render-svg (width height lines)
  (concatenate 'string
               (format nil "<svg height=\"~A\" width=\"~A\" xmlns=\"http://www.w3.org/2000/svg\">~%" height width)
               (render-polylines (calibrate lines))
               "</svg>"))

