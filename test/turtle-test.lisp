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
                     (up (forward 100 (down (forward 50 
                                                     (up (forward 200 (down (new-turtle))))))))))
               (assert-equal
                 '(
                   ((350.0d0 0.0d0) (250.0d0 0.0d0))
                   ((200.0d0 0.0d0) (0.0 0.0))
                   )
                 (trail f-turtle))))

(define-test lines-yield-trail-in-order
             (let ((f-turtle 
                     (up (forward 100 (down (forward 50 
                                                     (up (forward 200 (down (new-turtle))))))))))
               (assert-equal
                 '(
                   ((0.0 0.0) (200.0d0 0.0d0))
                   ((250.0d0 0.0d0) (350.0d0 0.0d0))
                   )
                 (lines f-turtle))))

(define-test executing-commands
             (let ((f-turtle
                     (execute '(
                                (GOTO (100 100))
                                (DOWN)
                                (FORWARD 50)
                                (RIGHT 90)
                                (FORWARD 25)
                                (LEFT 45)
                                (FORWARD 75)
                                (UP)
                                (GOTO (0 0))
                                (DOWN)
                                (TURN 100)
                                (FORWARD 100)
                                (UP))
                              (new-turtle))))
               (assert-equal
                 '(((100 100) (150.0d0 100.0d0) (150.0d0 75.0d0)
                              (203.03300858899107d0 21.96699141100894d0))
                   ((0 0) (-17.36481776669303d0 98.4807753012208d0)))
                 (lines f-turtle))))

(define-test loop-command
             (let ((f-turtle
                     (n-times 4 (lambda (turtle)
                                  (forward 100 turtle)) (new-turtle))))
               (assert-float-equal 400.0 (x f-turtle))))
