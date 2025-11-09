(require :asdf)
(require :lisp-unit)
(in-package :lisp-unit)
(setq *print-failures* t)
(load "src/turtle")

(define-test initially-turtle-at-zero
             (assert-float-equal 0.0 (x (new-turtle)))
             (assert-float-equal 0.0 (y (new-turtle))))

(define-test after-forward-coord-change
             (let ((f-turtle (forward 100 (new-turtle))))
               (assert-float-equal 100.0 (x f-turtle))))

(define-test after-turn-right-head-change
             (let ((r-turtle (right 45.0 (new-turtle))))
               (assert-float-equal -45.0 (head r-turtle))))

(define-test after-turn-left-head-change
             (let ((r-turtle (left 45.0 (new-turtle))))
               (assert-float-equal 45.0 (head r-turtle))))

(define-test initially-trail-is-empty
             (assert-equal t (null (trail (new-turtle)))))

(define-test after-one-move-with-pen-up-trail-unchanged
             (let ((f-turtle (forward 100 (up (new-turtle)))))
               (assert-equal '() (trail f-turtle))))

(define-test after-one-move-with-pen-down-trail-is-not-empty
             (let ((f-turtle (forward 100 (down (new-turtle)))))
               (assert-equal '(((0.0 0.0))) (trail f-turtle))))

(define-test pen-up-finishes-current-line-in-trail
             (let ((f-turtle
                     (up
                       (forward 100
                                (down (new-turtle))))))
               (assert-equal
                 '(((100.0d0 0.0d0) (0.0 0.0)))
                 (trail f-turtle))))

(define-test pen-down-starts-a-new-line-in-trail
             (let ((f-turtle
                     (up
                       (forward 100
                                (down
                                  (forward 50
                                           (up
                                             (forward 200
                                                      (down (new-turtle))))))))))
               (assert-equal
                 '(
                    ((350.0d0 0.0d0) (250.0d0 0.0d0))
                    ((200.0d0 0.0d0) (0.0 0.0))
                    )
                 (trail f-turtle))))

(run-tests :all)
(sb-ext:quit)
