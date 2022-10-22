(defsystem #:stw-mathml-test
  :description "Test suite for stw-mathml-parse."
  :depends-on ("parachute"
	       "stw-xml-parse"
	       "stw-mathml-parse")
  :serial t
  :components ((:file "package")
	       (:file "tests"))
  :perform (asdf:test-op (op c) (uiop:symbol-call :parachute :test :mathml.test)))
