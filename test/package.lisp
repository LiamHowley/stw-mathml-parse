(defpackage mathml.test
  (:use :cl :parachute :xml.parse :mathml.parse)
  (:export :test-parse))

(in-package mathml.test)

(define-test test-parse)
