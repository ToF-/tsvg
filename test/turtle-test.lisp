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

(run-tests :all)
(sb-ext:quit)
