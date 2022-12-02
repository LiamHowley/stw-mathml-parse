(in-package :cl-user)

(defpackage mathml.parse
  (:use :cl :xml.parse)

  (:import-from
   :contextl
   :singleton-class)

  (:import-from
   :stw.util
   :ensure-list
   :parse-stream)

  (:import-from
   :closer-mop
   :slot-definition-name
   :compute-effective-slot-definition
   :validate-superclass)

  (:export

   ;; specials
   :*preserve-whitespace*
   :*mathml-element-class-map*

   ;; meta
   :element-class
   :mathml-direct-slot-definition

   ;; model
   :define-mathml-node
   :document-node
   :xml-document-node
   :mathml-document-node
   :dom-node
   :standard-element-node
   :element-node
   :branch-node
   :leaf-node
   :content-node
   :text-node
   :whitespace-node
   :math

   :sgml-node
   :!--

   ;; functions
   :parse-document
   :read-element
   :read-element-name
   :read-element-attributes
   :read-attribute
   :read-attribute-value
   :read-content
   :read-into
   :read-subelements
   :bind-child-node
   :prepare-slot
   :assign-value
   :parse-value
   :get-element-name
   :map-attribute-to-slot
   :map-attribute
   :tag-open-char
   :serialize
   :write-to-file)

  (:export
   :find-ancestor-node
   :clone-node
   :walk-tree
   :retrieve-text-nodes
   :retrieve-text-nodes-with-token
   :retrieve-text-nodes-with-tokens
   :retrieve-text-nodes-with-all-tokens
   :get-elements-by-tagname
   :get-element-with-attribute
   :get-element-with-attributes
   :get-element-with-attribute-value
   :get-element-with-attribute-values
   :get-elements-with-attribute
   :get-elements-with-attributes
   :get-elements-with-attribute-value
   :get-elements-with-attribute-values
   :get-next-sibling
   :get-previous-sibling
   :query-select
   :query-select-all
   :remove-node
   :add-node
   :insert-before
   :insert-after
   :first-of-type
   :last-of-type)

  (:export
   :remove-reader
   :set-reader
   :read-mathml))
