(in-package mathml.parse)

(defclass mathml-document-node (xml-document-node)
  ())

(eval-when (:compile-toplevel :load-toplevel :execute)

  (defvar *all-elements* `(annotation annotation-xml maction math merror mfrac mi mmultiscripts mn mo mover mpadded mphantom mprescripts mroot mrow ms mspace msqrt mstyle msub msubsup msup mtable mtd mtext mtr munder munderover none semantics))

  (defclass grouping-element ()
    ()
    (:metaclass singleton-class))

  (defclass scripted-element ()
    ()
    (:metaclass singleton-class))

  (defclass radical-element ()
    ()
    (:metaclass singleton-class))

  (defvar *mathml-global-attributes `(mathml-class data-* dir displaystyle id mathbackground mathcolor mathsize mathvariant nonce scriptlevel mathml-style tabindex))

  (defvar *boolean-attributes* `(accent accentunder displaystyle separator stretchy symmetric)))


(defmacro define-mathml-node (name supers slots &rest rest)
  "Wrapper on DEFINE-ELEMENT-NODE macro. "
  ;; add global slots
  (loop
    for slot in *mathml-global-attributes*
    do (pushnew slot slots :test #'eq))
  `(eval-when (:compile-toplevel :load-toplevel :execute)
     (define-element-node ,name ,supers
       ,(loop
	  for slot in slots
	  do (setf slot (ensure-list slot))
	  when (member (car slot) *boolean-attributes* :test #'eq)
	    do (push 'boolean (cdr slot)) and
	  do (push :type (cdr slot))
	  collect slot)
       (:metaclass mathml-element-class)
       ,@rest)))


;;; element definitions

(define-mathml-node annotation ()
  ())

(define-mathml-node annotation-xml ()
  ())

(define-mathml-node maction (grouping-element)
  ((actiontype :status :deprecated)
   (selection :status :deprecated)))

(define-mathml-node math (grouping-element)
  ((xmlns :initform "http://www.w3.org/1998/Math/MathML")
   display))

(define-mathml-node merror (grouping-element)
  ())

(define-mathml-node menclose ()
  (notation)
  (:status . :non-core))

(define-mathml-node mfenced ()
  ((open :status :deprecated)
   (close :status :deprecated)
   (separators :status :deprecated))
  (:status . :deprecated))

(define-mathml-node mfrac ()
  ((denomalign :status :deprecated)
   (numalign :status :deprecated)
   linethickness))

(define-mathml-node mi ()
  ())

(define-mathml-node mmultiscripts (scripted-element)
  ((subscriptshift :status deprecated)
   (superscriptshift :status deprecated)))

(define-mathml-node mn ()
  ())

(define-mathml-node mo ()
  ((rquote :status :deprecated)
   accent lspace maxsize minsize movablelimits rspace separator stretchy symmetric))

(define-mathml-node mover (scripted-element)
  (accent))

(define-mathml-node mpadded ()
  (depth width height lspace voffset))

(define-mathml-node mphantom (grouping-element)
  ())

(define-mathml-node mprescripts (grouping-element)
  ())

(define-mathml-node mroot (radical-element)
  ())

(define-mathml-node mrow (grouping-element)
  ())

(define-mathml-node ms ()
  ((lquote :status :deprecated)))

(define-mathml-node mspace ()
  (width))

(define-mathml-node msqrt (radical-element)
  ())

(define-mathml-node mstyle (grouping-element)
  ((background :status :deprecated)
   (color :status :deprecated)
   (fontsize :status :deprecated)
   (fontstyle :status :deprecated)
   (fontfamily :status :deprecated)
   (fontweight :status :deprecated)
   (scriptminsize :status :deprecated)
   (scriptsizemultiplier :status :deprecated)))

(define-mathml-node msub (scripted-element)
  ((subscriptshift :status deprecated)
   (superscriptshift :status deprecated)))

(define-mathml-node msubsup (scripted-element)
  ((subscriptshift :status deprecated)
   (superscriptshift :status deprecated)))

(define-mathml-node msup (scripted-element)
  ())

(define-mathml-node mtable ()
  ((frame :expected-value ("none" "solid" "dashed"))
   align columnalign columnlines columnspacing framespacing rowalign rowlines rowspacing width))

(define-mathml-node mtd ()
  (columnalign columnspan rowalign rowspan))

(define-mathml-node mtext ()
  ())

(define-mathml-node mtr ()
  (columnalign rowalign))

(define-mathml-node munder (scripted-element)
   (accentunder))

(define-mathml-node munderover (scripted-element)
  (accent accentunder))

(define-mathml-node none (grouping-element)
  ())

(define-mathml-node semantics (grouping-element)
  ())
