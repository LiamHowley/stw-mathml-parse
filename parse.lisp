(in-package mathml.parse)

(defmethod initialize-instance :around ((child-node math) &key)
  (let ((*element-class-map* *mathml-element-class-map*))
    (call-next-method)))
