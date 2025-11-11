(require :asdf)
(require :lisp-unit)
(in-package :lisp-unit)
(setq *print-failures* t)
(load "src/svg")

(define-test render-a-polyline
             (assert-equal
               "<polyline points=\"25.00, 25.00 50.00, 150.00 100.00, 75.00 150.00, 50.00 200.00, 140.00 250.00, 140.00\" style=\"stroke:black; fill:none\" />"
               (render-polyline '((25 25) (50 150) (100 75) (150 50) (200 140) (250 140)))))

(define-test render-a-svg-as-list-of-polylines
             (let ((lines '(((25 25) (50 150) (100 75) (150 50) (200 140) (250 140))
                            ((25 100) (50 250) (100 175) (150 150) (200 240) (250 240)))))
               (assert-equal
                 (format nil "~A~%~A~%~A~%~A" 
                         "<svg height=\"400\" width=\"500\" xmlns=\"http://www.w3.org/2000/svg\">"
"<polyline points=\" 0.00, 400.00 25.00, 275.00 75.00, 350.00 125.00, 375.00 175.00, 285.00 225.00, 285.00\" style=\"stroke:black; fill:none\" />"
"<polyline points=\" 0.00, 325.00 25.00, 175.00 75.00, 250.00 125.00, 275.00 175.00, 185.00 225.00, 185.00\" style=\"stroke:black; fill:none\" />"
                         "</svg>")
                 (render-svg 500 400 lines))))

(define-test calibrate-a-list-of-lines
             (let ((lines '(((-25 25) (-50 150) (100 75) (150 50) (200 -140) (250 -140))
                            ((25 100) (50 250) (100 175) (150 150) (200 240) (250 240)))))
               (assert-equal
                 '(((25 165) (0 290) (150 215) (200 190) (250 0) (300 0))
                   ((75 240) (100 390) (150 315) (200 290) (250 380) (300 380)))
                 (calibrate lines))))

