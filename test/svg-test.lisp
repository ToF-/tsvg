(require :asdf)
(require :lisp-unit)
(in-package :lisp-unit)
(setq *print-failures* t)
(load "src/svg")

(define-test render-a-polyline
             (assert-equal
               "<polyline points=\"0,0 50,150 100,75 150,50 200,140 250,140\">"
               (render-polyline '((0 0) (50 150) (100 75) (150 50) (200 140) (250 140)))))

(define-test render-a-svg-as-list-of-polylines
             (let ((lines '(((0 0) (50 150) (100 75) (150 50) (200 140) (250 140))
                            ((0 100) (50 250) (100 175) (150 150) (200 240) (250 240)))))
                          
               (assert-equal
                 (format nil "~A~%~A~%~A~%~A" 
                         "svg height=\"400\" width=\"500\" xmlns=\"http://www.w3.org/2000/svg\">"
                         "<polyline points=\"0,0 50,150 100,75 150,50 200,140 250,140\">"
                         "<polyline points=\"0,100 50,250 100,175 150,150 200,240 250,240\">"
                         "</svg>")
                 (render-svg 500 400 lines))))
