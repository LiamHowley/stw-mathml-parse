(in-package mathml.parse)
  
(defun read-mathml (stream char)
  (declare (ignore char))
  (let ((next-char (read-char stream nil nil)))
    (case next-char
      (#\space
       (unread-char next-char stream)
       (return-from read-mathml (values (intern "<"))))
      (#\=
       (return-from read-mathml (values (intern "<="))))
      (t
       (unread-char next-char stream)
       (let ((output (with-output-to-string (out)
		       (write-char #\< out)
		       (parse-stream stream out))))
	 (parse-document (make-instance 'mathml-document-node :document output)))))))
