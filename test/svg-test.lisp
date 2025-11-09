(require :asdf)
(require :lisp-unit)
(in-package :lisp-unit)
(setq *print-failures* t)
(load "src/svg")

(define-test render-a-polyline
             (assert-equal
               "<polyline points=\"25.00, 25.00 50.00, 150.00 100.00, 75.00 150.00, 50.00 200.00, 140.00 250.00, 140.00\"/>"
               (render-polyline '((25 25) (50 150) (100 75) (150 50) (200 140) (250 140)))))

(define-test render-a-svg-as-list-of-polylines
             (let ((lines '(((25 25) (50 150) (100 75) (150 50) (200 140) (250 140))
                            ((25 100) (50 250) (100 175) (150 150) (200 240) (250 240)))))
                          
               (assert-equal
                 (format nil "~A~%~A~%~A~%~A" 
                         "<svg height=\"400\" width=\"500\" xmlns=\"http://www.w3.org/2000/svg\">"
                         "<polyline points=\"25.00, 25.00 50.00, 150.00 100.00, 75.00 150.00, 50.00 200.00, 140.00 250.00, 140.00\"/>"
                         "<polyline points=\"25.00, 100.00 50.00, 250.00 100.00, 175.00 150.00, 150.00 200.00, 240.00 250.00, 240.00\"/>"
                         "</svg>")
                 (render-svg 500 400 lines))))
