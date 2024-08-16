(set-option :smt.mbqi false)
(set-option :smt.auto-config false)

(declare-sort JSValue 0)
(declare-fun type (JSValue) Int)
(declare-fun Null () JSValue)
(declare-fun IsStrictlyEqual (JSValue JSValue) Bool)
(declare-fun y0 () JSValue)

; (assert (forall ((x JSValue))
;   (! (and (>= (type x) 0) (<= (type x) 0)) :pattern ((type x)))))
; 

(assert (forall ((x JSValue)) (! (= (= (type x) 0) (= x Null)) :pattern ((type x)))))

; 
; (assert (forall ((x JSValue))
;   (! (IsStrictlyEqual x x) :pattern ((IsStrictlyEqual x x)))))
; 

(assert (forall ((x JSValue) (y JSValue))
  (! (=> (IsStrictlyEqual x y) (= (type x) (type y)))
     :pattern ((IsStrictlyEqual x y))
     :pattern ((IsStrictlyEqual y x)))))

(push)

(assert (and (IsStrictlyEqual y0 Null) (= y0 Null)))

(check-sat)
(get-info :reason-unknown)
(get-model)
