(require :asdf)
(require :lisp-unit)
(in-package :lisp-unit)
(setq *print-failures* t)

(load "test/svg-test")
(load "test/turtle-test")

(run-tests :all)
(sb-ext:quit)
