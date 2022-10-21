(in-package mathml.parse)

(defclass mathml-element-class (element-class)
  ((status :initform :active
	   :initarg :status
	   :reader status)))

(defclass mathml-direct-slot-definition (xml-direct-slot-definition)
  ()
  (:documentation "default class representing mathml attribute slots"))

(defclass mathml-effective-slot-definition (xml-effective-slot-definition)
  ())

(defmethod direct-slot-definition-class
    ((class mathml-element-class) &key &allow-other-keys)
  (find-class 'mathml-direct-slot-definition))

(defmethod effective-slot-definition-class
    ((class mathml-element-class) &key &allow-other-keys)
  (call-next-method))

(defmethod compute-effective-slot-definition
    ((class mathml-element-class) name direct-slot-definitions)
  (call-next-method))

(defmethod validate-superclass
    ((class mathml-element-class)
     (superclass element-class))
  t)

(defmethod validate-superclass
    ((superclass element-class)
     (class mathml-element-class))
  t)

(defvar *mathml-element-class-map*
  (let ((table (make-hash-table :test #'equal)))
    (maphash #'(lambda (element class)
		 (setf (gethash element table) class))
	     *element-class-map*)
    table)
  "Copying the elements from XML.PARSE:*ELEMENT-CLASS-MAP* 
as they may well be called upon during parsing.")

(defmethod shared-initialize :around ((class mathml-element-class) slot-names &key)
  (declare (ignore slot-names))
  ;; as there are overlapping/duplicate element names/classes between mathml and html
  ;; we need to specify the correct hash-table for writing.
  (let ((*element-class-map* *mathml-element-class-map*))
    (call-next-method)))
