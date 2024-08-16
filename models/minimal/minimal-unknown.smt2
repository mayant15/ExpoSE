(set-option :smt.mbqi false)
(set-option :smt.auto_config false)

(declare-sort JSValue 0)
(declare-fun Null () JSValue)
(declare-fun type (JSValue) Int)
(declare-fun strictEqual (JSValue JSValue) Bool)
(declare-fun x () JSValue)

(assert (forall ((x JSValue)) (= (= (type x) 0) (= x Null))))
(assert (forall ((x JSValue) (y JSValue))
  (! (=> (strictEqual x y) (= (type x) (type y))) :pattern ((strictEqual x y)))))
(assert (=> (strictEqual x Null) (= x Null)))

