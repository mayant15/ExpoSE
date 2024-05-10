(get-info :version)
; (:version "4.13.0 - build hashcode 3049f578a8f98a0b0992eca193afe57a73b30ca3")
; Started: 2024-05-10 13:29:22
; Silicon.version: 1.1-SNAPSHOT (657658bc+)
; Input file: ./models/primitives.vpr
; Verifier id: 00
; ------------------------------------------------------------
; Begin preamble
; ////////// Static preamble
; 
; ; /z3config.smt2
(set-option :print-success true) ; Boogie: false
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
; 
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
(declare-const TypeError<JSValue> JSValue)
(declare-fun type<Int> (JSValue) Int)
(declare-fun toNumber<Int> (JSValue) Int)
(declare-fun toBoolean<Bool> (JSValue) Bool)
(declare-fun addition<JSValue> (JSValue JSValue) JSValue)
(declare-fun isStrictlyEqual<Bool> (JSValue JSValue) Bool)
; Declaring symbols related to program functions (from program analysis)
; Snapshot variable to be used during function verification
(declare-fun s@$ () $Snap)
; Declaring predicate trigger functions
; ////////// Uniqueness assumptions from domains
; ////////// Axioms
(assert (forall ((i Int) (j Int)) (!
  (=> (= (Number<JSValue> i) (Number<JSValue> j)) (= i j))
  :pattern ((Number<JSValue> i) (Number<JSValue> j))
  )))
(assert (forall ((i Bool) (j Bool)) (!
  (=> (= (Boolean<JSValue> i) (Boolean<JSValue> j)) (= i j))
  :pattern ((Boolean<JSValue> i) (Boolean<JSValue> j))
  )))
(assert (forall ((x JSValue)) (!
  (and (>= (type<Int> x) 0) (<= (type<Int> x) 4))
  :pattern ((type<Int> x))
  )))
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
(assert (forall ((x JSValue)) (!
  (=>
    (= (type<Int> x) 2)
    (exists ((i Int)) (!
      (= x (Number<JSValue> i))
      :pattern ((Number<JSValue> i))
      )))
  :pattern ((type<Int> x))
  )))
(assert (forall ((b Bool)) (!
  (= (type<Int> (Boolean<JSValue> b)) 3)
  :pattern ((type<Int> (Boolean<JSValue> b)))
  )))
(assert (forall ((x JSValue)) (!
  (=>
    (= (type<Int> x) 3)
    (exists ((b Bool)) (!
      (= x (Boolean<JSValue> b))
      :pattern ((Boolean<JSValue> b))
      )))
  :pattern ((type<Int> x))
  )))
(assert (forall ((a JSValue) (b JSValue)) (!
  (=> (= a b) (= (type<Int> a) (type<Int> b)))
  :pattern ((type<Int> a) (type<Int> b))
  )))
(assert (= (type<Int> (as TypeError<JSValue>  JSValue)) 4))
(assert (forall ((x JSValue)) (!
  (=> (= (type<Int> x) 4) (= x (as TypeError<JSValue>  JSValue)))
  :pattern ((type<Int> x))
  )))
(assert (forall ((i Int)) (!
  (= (toNumber<Int> (Number<JSValue> i)) i)
  :pattern ((toNumber<Int> (Number<JSValue> i)))
  )))
(assert (forall ((b Bool)) (!
  (= (toBoolean<Bool> (Boolean<JSValue> b)) b)
  :pattern ((toBoolean<Bool> (Boolean<JSValue> b)))
  )))
(assert (forall ((x Int) (y Int)) (!
  (=
    (addition<JSValue> (Number<JSValue> x) (Number<JSValue> y))
    (Number<JSValue> (+ x y)))
  :pattern ((addition<JSValue> (Number<JSValue> x) (Number<JSValue> y)))
  )))
(assert (forall ((x JSValue) (y JSValue)) (!
  (=>
    (or (not (= (type<Int> x) 2)) (not (= (type<Int> y) 2)))
    (= (addition<JSValue> x y) (as TypeError<JSValue>  JSValue)))
  :pattern ((addition<JSValue> x y))
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
; State saturation: after preamble
(set-option :timeout 100)
(check-sat)
; unknown
