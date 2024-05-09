(get-info :version)

(set-option :global-decls true) ; Necessary for push pop mode
(set-option :auto_config false)
(set-option :smt.case_split 3)
(set-option :smt.delay_units true)
(set-option :type_check true)
(set-option :smt.mbqi false)
(set-option :pp.bv_literals false)
(set-option :smt.qi.eager_threshold 100)
(set-option :smt.arith.solver 2)
(set-option :model.v2 true)
(set-option :smt.qi.max_multi_patterns 1000)

(declare-sort JSValue 0)
(declare-const Null<JSValue> JSValue)
(declare-const Undefined<JSValue> JSValue)
(declare-fun Number<JSValue> (Int) JSValue)
(declare-fun Boolean<JSValue> (Bool) JSValue)
(declare-fun type<Int> (JSValue) Int)
(declare-fun isStrictlyEqual<Bool> (JSValue JSValue) Bool)

(assert (= (type<Int> (as Null<JSValue>  JSValue)) 0))
(assert (forall ((x JSValue)) (!
  (=> (= (type<Int> x) 0) (= x (as Null<JSValue>  JSValue)))
  :pattern ((type<Int> x))
  )))
(assert (= (type<Int> (as Undefined<JSValue>  JSValue)) 1))
(assert (forall ((x JSValue)) (!
  (=> (= (type<Int> x) 1) (= x (as Undefined<JSValue>  JSValue)))
  :pattern ((type<Int> x))
  )))
(assert (forall ((i Int)) (!
  (= (type<Int> (Number<JSValue> i)) 2)
  :pattern ((type<Int> (Number<JSValue> i)))
  )))
(assert (forall ((b Bool)) (!
  (= (type<Int> (Boolean<JSValue> b)) 3)
  :pattern ((type<Int> (Boolean<JSValue> b)))
  )))
(assert (forall ((a JSValue) (b JSValue)) (!
  (=> (= a b) (= (type<Int> a) (type<Int> b)))
  :pattern ((type<Int> a) (type<Int> b))
  )))
(assert (forall ((a JSValue) (b JSValue)) (!
  (=>
    (not (= (type<Int> a) (type<Int> b)))
    (= (isStrictlyEqual<Bool> a b) false))
  :pattern ((isStrictlyEqual<Bool> a b))
  )))
(assert (forall ((i Int) (j Int)) (!
  (= (isStrictlyEqual<Bool> (Number<JSValue> i) (Number<JSValue> j)) (= i j))
  :pattern ((isStrictlyEqual<Bool> (Number<JSValue> i) (Number<JSValue> j)))
  )))
(assert (forall ((a Bool) (b Bool)) (!
  (= (isStrictlyEqual<Bool> (Boolean<JSValue> a) (Boolean<JSValue> b)) (= a b))
  :pattern ((isStrictlyEqual<Bool> (Boolean<JSValue> a) (Boolean<JSValue> b)))
  )))
(assert (=
  (isStrictlyEqual<Bool> (as Null<JSValue>  JSValue) (as Null<JSValue>  JSValue))
  true))
(assert (=
  (isStrictlyEqual<Bool> (as Undefined<JSValue>  JSValue) (as Undefined<JSValue>  JSValue))
  true))

(set-option :timeout 100)
(check-sat)
; unknown

; ------------------------------------------------------------
; Begin function- and predicate-related preamble
; Declaring symbols related to program functions (from verification)
; End function- and predicate-related preamble
; ------------------------------------------------------------
; ---------- test ----------
(declare-const x@1@01 JSValue)
(set-option :timeout 0)
(push) ; 1
; State saturation: after contract
(set-option :timeout 50)
(check-sat)
; unknown
(set-option :timeout 0)

(assert (= x@1@01 Null<JSValue>))
(check-sat)
(get-info :reason-unknown)
(get-model)

; (push) ; 2
; 
; (push) ; 3
; 
; (assert (not (not (= x@1@01 (as Null<JSValue>  JSValue)))))
; (check-sat)
; ; unknown
; (get-model)
; 
; (pop) ; 3

; (set-option :timeout 10)
; (check-sat)
; 
; (set-option :timeout 0)
; (push) ; 3
; (assert (not (not (= x@1@01 (as Null<JSValue>  JSValue)))))
; (check-sat)
; (get-model)
; 
; (pop) ; 3
; 
; (set-option :timeout 10)
; (check-sat)
; (set-option :timeout 0)
; 
; (push) ; 3
; 
; (assert (not (not (= x@1@01 (as Null<JSValue>  JSValue)))))
; (check-sat)
; ; unknown
; (get-model)
; 
; (pop) ; 3
; 
; (set-option :timeout 10)
; (check-sat)
; (set-option :timeout 0)
; 
; (push) ; 3
; 
; (assert (not (not (= x@1@01 (as Null<JSValue>  JSValue)))))
; (check-sat)
; ; unknown
; (get-model)
; 
; (pop) ; 3

; (pop) ; 2

(pop) ; 1
