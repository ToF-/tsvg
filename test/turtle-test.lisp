(require :asdf)
(require :lisp-unit)
(in-package :lisp-unit)
(setq *print-failures* t)
(load "src/turtle")

(define-test new-turtle-has-pen-up
             (assert-equal nil (pen-down? (new-turtle))))

(define-test turtle-can-down-pen
             (assert-equal t (pen-down? (pen-down (new-turtle)))))

(define-test turtle-can-up-pen
             (assert-equal nil
                           (pen-down? (pen-up (pen-down (new-turtle))))))

(define-test initially-turtle-at-zero
             (assert-float-equal 0.0 (x (new-turtle)))
             (assert-float-equal 0.0 (y (new-turtle))))

(define-test after-forward-coord-change
             (let ((f-turtle (forward 100 (new-turtle))))
               (assert-float-equal 100.0 (x f-turtle))))

(define-test after-turn-right-heading-change
             (let ((r-turtle (right 45.0 (new-turtle))))
               (assert-float-equal -45.0 (heading r-turtle))))

(define-test after-turn-left-heading-change
             (let ((r-turtle (left 45.0 (new-turtle))))
               (assert-float-equal 45.0 (heading r-turtle))))

(define-test initially-trail-is-empty
             (assert-equal t (null (trail (new-turtle)))))

(run-tests :all)
(sb-ext:quit)
