(in-package mathml.parse)


(defmethod parse-document ((document mathml-document-node) &key (parser #'read-element) preserve-whitespace)
  (let ((*element-class-map* *mathml-element-class-map*))
    (call-next-method)))


(defmethod initialize-instance :around ((child-node math) &key)
  (let ((*element-class-map* *mathml-element-class-map*))
    (call-next-method)))
