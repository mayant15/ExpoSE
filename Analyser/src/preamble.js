const PREAMBLE = `
; ; /preamble.smt2
(declare-datatypes (($Snap 0)) ((
    ($Snap.unit)
    ($Snap.combine ($Snap.first $Snap) ($Snap.second $Snap)))))
(declare-sort $Ref 0)
(declare-const $Ref.null $Ref)
(declare-sort $FPM 0)
(declare-sort $PPM 0)
(define-sort $Perm () Real)
(define-const $Perm.Write $Perm 1.0)
(define-const $Perm.No $Perm 0.0)
(define-fun $Perm.isValidVar ((p $Perm)) Bool
	(<= $Perm.No p))
(define-fun $Perm.isReadVar ((p $Perm)) Bool
    (and ($Perm.isValidVar p)
         (not (= p $Perm.No))))
(define-fun $Perm.min ((p1 $Perm) (p2 $Perm)) Real
    (ite (<= p1 p2) p1 p2))
(define-fun $Math.min ((a Int) (b Int)) Int
    (ite (<= a b) a b))
(define-fun $Math.clip ((a Int)) Int
    (ite (< a 0) 0 a))
; ////////// Sorts
(declare-sort JSValue 0)
; ////////// Sort wrappers
; Declaring additional sort wrappers
(declare-fun $SortWrappers.IntTo$Snap (Int) $Snap)
(declare-fun $SortWrappers.$SnapToInt ($Snap) Int)
(assert (forall ((x Int)) (!
    (= x ($SortWrappers.$SnapToInt($SortWrappers.IntTo$Snap x)))
    :pattern (($SortWrappers.IntTo$Snap x))
    :qid |$Snap.$SnapToIntTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.IntTo$Snap($SortWrappers.$SnapToInt x)))
    :pattern (($SortWrappers.$SnapToInt x))
    :qid |$Snap.IntTo$SnapToInt|
    )))
(declare-fun $SortWrappers.BoolTo$Snap (Bool) $Snap)
(declare-fun $SortWrappers.$SnapToBool ($Snap) Bool)
(assert (forall ((x Bool)) (!
    (= x ($SortWrappers.$SnapToBool($SortWrappers.BoolTo$Snap x)))
    :pattern (($SortWrappers.BoolTo$Snap x))
    :qid |$Snap.$SnapToBoolTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.BoolTo$Snap($SortWrappers.$SnapToBool x)))
    :pattern (($SortWrappers.$SnapToBool x))
    :qid |$Snap.BoolTo$SnapToBool|
    )))
(declare-fun $SortWrappers.$RefTo$Snap ($Ref) $Snap)
(declare-fun $SortWrappers.$SnapTo$Ref ($Snap) $Ref)
(assert (forall ((x $Ref)) (!
    (= x ($SortWrappers.$SnapTo$Ref($SortWrappers.$RefTo$Snap x)))
    :pattern (($SortWrappers.$RefTo$Snap x))
    :qid |$Snap.$SnapTo$RefTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.$RefTo$Snap($SortWrappers.$SnapTo$Ref x)))
    :pattern (($SortWrappers.$SnapTo$Ref x))
    :qid |$Snap.$RefTo$SnapTo$Ref|
    )))
(declare-fun $SortWrappers.$PermTo$Snap ($Perm) $Snap)
(declare-fun $SortWrappers.$SnapTo$Perm ($Snap) $Perm)
(assert (forall ((x $Perm)) (!
    (= x ($SortWrappers.$SnapTo$Perm($SortWrappers.$PermTo$Snap x)))
    :pattern (($SortWrappers.$PermTo$Snap x))
    :qid |$Snap.$SnapTo$PermTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.$PermTo$Snap($SortWrappers.$SnapTo$Perm x)))
    :pattern (($SortWrappers.$SnapTo$Perm x))
    :qid |$Snap.$PermTo$SnapTo$Perm|
    )))
; Declaring additional sort wrappers
(declare-fun $SortWrappers.JSValueTo$Snap (JSValue) $Snap)
(declare-fun $SortWrappers.$SnapToJSValue ($Snap) JSValue)
(assert (forall ((x JSValue)) (!
    (= x ($SortWrappers.$SnapToJSValue($SortWrappers.JSValueTo$Snap x)))
    :pattern (($SortWrappers.JSValueTo$Snap x))
    :qid |$Snap.$SnapToJSValueTo$Snap|
    )))
(assert (forall ((x $Snap)) (!
    (= x ($SortWrappers.JSValueTo$Snap($SortWrappers.$SnapToJSValue x)))
    :pattern (($SortWrappers.$SnapToJSValue x))
    :qid |$Snap.JSValueTo$SnapToJSValue|
    )))
; ////////// Symbols
(declare-const Null<JSValue> JSValue)
(declare-const Undefined<JSValue> JSValue)
(declare-fun Number<JSValue> (Int) JSValue)
(declare-fun Boolean<JSValue> (Bool) JSValue)
(declare-fun type<Int> (JSValue) Int)
(declare-fun isStrictlyEqual<Bool> (JSValue JSValue) Bool)
; Declaring symbols related to program functions (from program analysis)
; Snapshot variable to be used during function verification
(declare-fun s@$ () $Snap)
; Declaring predicate trigger functions
; ////////// Uniqueness assumptions from domains
; ////////// Axioms
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
; End preamble
; ------------------------------------------------------------
`;

export default PREAMBLE;
