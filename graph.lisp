(require 'parenscript)
(require 'cl-who)
(defpackage "graph"
  (:use :common-lisp :parenscript))

(in-package "graph")

(with-open-file
 (stream "/Users/indy/dev/parengraph/graph.html" :direction :output :if-exists :supersede)
 (cl-who:with-html-output (stream)
  (:html
   (:body
    (:script :type "text/javascript"
             :src "../raphael/raphael.js")
    (:script :type "text/javascript"
             (cl-who:str
              (parenscript:ps
               (let ((page (new (*raphael 0 0 800 600))))
                (defun graph-node (name)
                  (let* ((x 50)
                         (y 50)
                         (w 100)
                         (h 80)
                         (rect ((@ page rect) x y w h 5))
                         (text ((@ page text) (+ x (/ w 2)) (+ y (/ h 2)) name))
                         (px 0)
                         (py 0)
                         (drag (lambda (dx dy)
                                 ((@ text translate) (- dx px) (- dy py))
                                 ((@ rect translate) (- dx px) (- dy py))
                                 (setf px dx)
                                 (setf py dy)))
                         (down (lambda () nil))
                         (up (lambda ()
                               (setf px 0)
                               (setf py 0))))

                    ((@ rect attr) "fill" "#96f2ee")
                    ((@ rect attr) "stroke" "#fff")

                    ((@ rect drag)
                     drag
                     down
                     up)
                    ((@ text drag)
                     drag
                     down
                     up)))

                (graph-node "One")
                (graph-node "Two")))))))))