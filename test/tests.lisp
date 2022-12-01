(in-package mathml.test)

(defvar *mathml*
  "<math display=\"block\">
    <mrow id=\"outer-row\">
      <munderover>
	<mo>∑</mo>
	<mrow class=\"inner-row\">
	  <mi>n</mi>
	  <mo>=</mo>
	  <mn>1</mn>
	</mrow>
	<mrow class=\"inner-row\">
	  <mo>+</mo>
	  <mn>∞</mn>
	</mrow>
      </munderover>
      <mfrac>
	<mn>1</mn>
	<msup>
	  <mi>n</mi>
	  <mn>2</mn>
	</msup>
      </mfrac>
    </mrow>
  </math>")

(defvar *parsed-mathml* (parse-document (make-instance 'mathml-document-node :document *mathml*)))

(define-test parse-mathml...
  :parent test-parse
  (of-type 'mathml-document-node *parsed-mathml*)
  (let ((element (car (get-elements-by-tagname *parsed-mathml* "mo" *mathml-element-class-map*))))
    (of-type 'mathml.parse::mo element)
    (of-type 'mathml.parse::mathml-element-class (class-of element)))
  (of-type 'element-node (car (slot-value *parsed-mathml* 'child-nodes)))
  (of-type 'mathml.parse::math (get-element-with-attribute *parsed-mathml* "display"))
  ;; this is mathml where attribute values can only be a string. This should be false
  (let ((element (get-elements-with-attribute-value *parsed-mathml* "class" "inner-row")))
    (true (typep (car element) 'mathml.parse::mrow))
    (true (typep (cadr element) 'mathml.parse::mrow)))
  (let ((element (get-element-with-attribute-values *parsed-mathml* "id" "outer-row")))
    (true (typep element 'mathml.parse::mrow)))
  (let ((text-nodes (retrieve-text-nodes *parsed-mathml*)))
    (is string= "∑" (text (car text-nodes)))
    (of-type 'mathml.parse::mrow (get-next-sibling (parent-node (car text-nodes))))))

(define-test reader...
  :parent test-parse
  (when (readerp)
    (remove-reader))
  (true (set-reader #'read-mathml))
  (let* ((document-node (read-from-string "<mfrac linethickness=\"0\"><mi>n</mi><mi>k</mi></mfrac>"))
	 (child-node (car (slot-value document-node 'child-nodes)))
	 (mi (car (get-elements-by-tagname document-node "mi" *mathml-element-class-map*))))
    (true (slot-exists-p child-node 'mathml.parse::linethickness))
    (is string= "0" (slot-value child-node 'mathml.parse::linethickness))
    (is string= "n" (text (car (slot-value mi 'child-nodes))))
    (of-type 'readtable (remove-reader))))
