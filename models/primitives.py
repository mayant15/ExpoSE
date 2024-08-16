from z3 import (
        Solver, DeclareSort, Function, Consts, IntSort, BoolSort, Implies,
        ForAll, MultiPattern, unknown, And, Or, Exists, Not, OnClause, unsat,
        set_param, StringSort, StringVal, Concat, BoolVal
)

############################################################################
# Config

print_proof_logs = False
enable_strict_eq_tests = True
enable_plus_tests = True

############################################################################
# Definitions

JSValue = DeclareSort('JSValue')
Null, Undefined, TypeError_ = Consts(['Null', 'Undefined', 'TypeError'], JSValue)
type_ = Function('type', JSValue, IntSort())
Number = Function('Number', IntSort(), JSValue)
Boolean = Function('Boolean', BoolSort(), JSValue)
String = Function('JString', StringSort(), JSValue)


def RawStr(s):
    return String(StringVal(s))


i, j = Consts('i j', IntSort())
x, y = Consts('x y', JSValue)
b, c = Consts('b c', BoolSort())
s0, s1 = Consts('s0 s1', StringSort())

axioms = []


def axiom(expr):
    axioms.append(expr)


def log_instance(pr, arg1, arg2):
    if pr.decl().name() == "inst":
        print(pr, arg1, arg2)
        print()


s = Solver()
s.set(":mbqi", False)
s.set(":auto_config", False)
if print_proof_logs:
    set_param(proof=True)
    onc = OnClause(s, print)


total = 0
passed = 0


def ert(expr):
    global total
    global passed

    total = total + 1
    s.push()
    s.add(Not(expr))
    res = s.check()
    if res == unsat:
        passed = passed + 1
    elif res == unknown:
        print('[!] assert:', expr.sexpr())
        print('[!] assert might fail. reason:', s.reason_unknown())
        print()
    else:
        print('[!] assert:', expr.sexpr())
        print('[!] assert might fail. model:', s.model())
        print()
    s.pop()


############################################################################
# AXIOMS
############################################################################

# Injective for Number
axiom(ForAll([i, j], Implies(Number(i) == Number(j), i == j), patterns=[
    MultiPattern(Number(i), Number(j))
    ]))

# Injective for Boolean
axiom(ForAll([b, c], Implies(Boolean(b) == Boolean(c), b == c), patterns=[
    MultiPattern(Boolean(b), Boolean(c))
    ]))

# Injective for String
axiom(ForAll([s0, s1], Implies(String(s0) == String(s1), s0 == s1), patterns=[
    MultiPattern(String(s0), String(s1))
    ]))

############################################################################
# Type tag for values

NULL_TAG = 0
UNDEFINED_TAG = 1
NUMBER_TAG = 2
BOOLEAN_TAG = 3
STRING_TAG = 4
TYPE_ERROR_TAG = 5

# type(x) \in {0, 1, 2, 3, 4, 5}
x, y = Consts('x y', JSValue)
axiom(ForAll(x, And(type_(x) >= 0, type_(x) <= 5), patterns=[type_(x)]))

#  forall x: JSValue :: {type(x)} type(x) == 0 <==> x == Null
axiom(ForAll(x, (type_(x) == NULL_TAG) == (x == Null), patterns=[type_(x)]))

#  forall x: JSValue :: {type(x)} type(x) == 1 <==> x == Undefined
axiom(ForAll(x, (type_(x) == UNDEFINED_TAG) == (x == Undefined), patterns=[type_(x)]))

# forall i: Int :: {type(Number(i))} type(Number(i)) == 2
# forall x: JSValue :: {type(x)} type(x) == 2 ==> exists i: Int :: x == Number(i)
axiom(ForAll(i, type_(Number(i)) == NUMBER_TAG, patterns=[type_(Number(i))]))
axiom(ForAll(x, Implies(type_(x) == NUMBER_TAG, Exists(i, x == Number(i))), patterns=[type_(x)]))

# type(x) == 3 iff x is a Boolean
axiom(ForAll(b, type_(Boolean(b)) == BOOLEAN_TAG, patterns=[type_(Boolean(b))]))
axiom(ForAll(x, Implies(type_(x) == BOOLEAN_TAG, Exists(b, x == Boolean(b))), patterns=[type_(x)]))

# type(x) == 4 iff x is a String
axiom(ForAll(s0, type_(String(s0)) == STRING_TAG, patterns=[type_(String(s0))]))
axiom(ForAll(x, Implies(type_(x) == STRING_TAG, Exists(s0, x == String(s0))), patterns=[type_(x)]))

# type(x) == 5 iff x == TypeError()
axiom(ForAll(x, (type_(x) == 5) == (x == TypeError_), patterns=[type_(x)]))

############################################################################
# Type coercion functions

toBoolean = Function('ToBoolean', JSValue, BoolSort())

axiom(ForAll(b, toBoolean(Boolean(b)) == b, patterns=[toBoolean(Boolean(b))]))

############################################################################
# https://tc39.es/ecma262/#sec-tonumber
# ToNumber

ToNumber = Function('ToNumber', JSValue, IntSort())

axiom(ForAll(i, ToNumber(Number(i)) == i, patterns=[ToNumber(Number(i)), Number(i)]))
axiom(ToNumber(Undefined) == 0)  #  TODO: This should be NaN
axiom(ToNumber(Null) == 0)
axiom(ToNumber(Boolean(False)) == 0)
axiom(ToNumber(Boolean(True)) == 1)
# axiom(ForAll(i, ToNumber(Number(i)) != ToNumber(TypeError_), patterns=[
#     ToNumber(Number(i)),
#     ]))
# axiom(ToNumber(TypeError_) == -1)
# axiom(ForAll(s0, ToNumber(String(s0)) == -1, patterns=[
#     ToNumber(String(s0)),
#     String(s0)
#     ]))

############################################################################
# https://tc39.es/ecma262/#sec-tostring
# ToString

#  TODO: Do I need two ToString functions? One that's JSValue -> StringSort
#  and another one that's JSValue -> JSValue
ToString = Function('ToString', JSValue, StringSort())

axiom(ForAll(s0, ToString(String(s0)) == s0, patterns=[ToString(String(s0))]))
axiom(ToString(Null) == StringVal("null"))
axiom(ToString(Undefined) == StringVal("undefined"))
axiom(ToString(Boolean(True)) == StringVal("true"))
axiom(ToString(Boolean(False)) == StringVal("false"))

############################################################################
#  NOTE: string->number and number->string conversions are not precisely
#  defined besides these two axioms

axiom(ForAll(i, ToNumber(String(ToString(Number(i)))) == i))
axiom(ForAll(s0, ToString(Number(ToNumber(String(s0)))) == s0)) #  TODO: Parse number from string can fail

############################################################################
# https://tc39.es/ecma262/#sec-applystringornumericbinaryoperator
# `+` operator
#  TODO: Will have to model ToPrimitive at some point because that's where we
#  get "[Object object]" from. Not modelling custom type coercion overrides for
#  now like Symbol.toPrimitive or Object.prototype.valueOf

plus = Function('plus', JSValue, JSValue, JSValue)

# If either argument is a string, perform string concatenation
#  NOTE: I can do this on type(), or I can do this pattern matched on String(s)

# forall x, y : JSValue :: {plus(x, y)} (type(x) == STRING_TAG || type(y) == STRING_TAG) ==> (plus(x, y) ==
# String(Concat(ToString(x), ToString(y)))
axiom(ForAll([x, y], Implies(
    Or(type_(x) == STRING_TAG, type_(y) == STRING_TAG),
    plus(x, y) == String(Concat(ToString(x), ToString(y)))
    ), patterns=[
        plus(x, y)
        ]))

#  TODO: Handle TypeError or throw
axiom(ForAll([x, y], Implies(
    And(type_(x) != STRING_TAG, type_(y) != STRING_TAG),
    plus(x, y) == Number(ToNumber(x) + ToNumber(y))
    ), patterns=[plus(x, y)]))

############################################################################
# https://262.ecma-international.org/#sec-isstrictlyequal
# `===` operator

#  TODO: This needs to return a JSValue that's boolean instead of BoolSort, to
# be able to use results in larger expressions
strictEqual = Function('IsStrictlyEqual', JSValue, JSValue, BoolSort())

# Reflexive
axiom(ForAll(x, strictEqual(x, x), patterns=[strictEqual(x, x)]))

# !(x === y) if they have different types
axiom(ForAll([x, y], Implies(strictEqual(x, y), type_(x) == type_(y)), patterns=[
    strictEqual(x, y),
    ]))

# For two numbers, x === y iff their numeric values are the same
axiom(ForAll([i, j], strictEqual(Number(i), Number(j)) == (i == j), patterns=[
    strictEqual(Number(i), Number(j))
    ]))

# For two booleans, x === y iff their boolean values are the same
axiom(ForAll([b, c], strictEqual(Boolean(b), Boolean(c)) == (b == c), patterns=[
    strictEqual(Boolean(b), Boolean(c))
    ]))

# For two strings, x === y iff their string values are the same
axiom(ForAll([s0, s1], strictEqual(String(s0), String(s1)) == (s0 == s1), patterns=[
    strictEqual(String(s0), String(s1))
    ]))

############################################################################
# TESTS
############################################################################

s.add(axioms)

############################################################################
# strictEqual

if enable_strict_eq_tests:
    # === for null
    ert(ForAll(x, Implies(strictEqual(x, Null), x == Null), patterns=[
        strictEqual(x, Null)
        ]))
    ert(strictEqual(Null, Null))

    # === for undefined
    ert(ForAll(x, Implies(strictEqual(x, Undefined), x == Undefined), patterns=[
        strictEqual(x, Undefined)
        ]))
    ert(strictEqual(Undefined, Undefined))

    # === for numbers
    ert(strictEqual(Number(1), Number(1)))
    ert(strictEqual(Number(0), Number(0)))
    ert(Not(strictEqual(Number(1), Number(4))))

    # === for booleans
    ert(strictEqual(Boolean(True), Boolean(True)))
    ert(Not(strictEqual(Boolean(False), Boolean(True))))
    ert(Not(strictEqual(Boolean(True), Boolean(False))))
    ert(strictEqual(Boolean(False), Boolean(False)))

    # === for strings
    ert(strictEqual(RawStr("abc"), RawStr("abc")))
    ert(Not(strictEqual(RawStr("abc"), RawStr("ab"))))

    # === for differing types
    ert(Not(strictEqual(Boolean(True), Number(1))))
    ert(Not(strictEqual(Boolean(True), RawStr("abc"))))

############################################################################
# plus

if enable_plus_tests:
    # + gives you either number or string
    ert(ForAll([x, y], Or(type_(plus(x, y)) == NUMBER_TAG, type_(plus(x, y)) == STRING_TAG)))

    # Do some basic arithmetic
    # ert(Implies(strictEqual(plus(x, Number(3)), Number(45)), x == Number(42)))

    ert(Implies(strictEqual(plus(x, Number(3)), Number(45)), ToNumber(x) == 42))

    ert(Implies(strictEqual(plus(x, Number(3)), Number(45)), Or(
        type_(x) == NUMBER_TAG,
        type_(x) == TYPE_ERROR_TAG,
        )))

    ert(Implies(ToNumber(x) == 42, Or(
        type_(x) == NUMBER_TAG,
        type_(x) == STRING_TAG,
        type_(x) == TYPE_ERROR_TAG,
        )))

    # null + null is 0
    ert(plus(Null, Null) == Number(0))

    # null + i is i
    ert(plus(Null, Number(42)) == Number(42))

    # null + "abc" is "nullabc"
    ert(plus(Null, RawStr("abc")) == RawStr("nullabc"))

    # undefined + "abc" is "undefinedabc"
    ert(plus(Undefined, RawStr("abc")) == RawStr("undefinedabc"))

    # "abc" + true is "abctrue"
    ert(plus(RawStr("abc"), Boolean(True)) == RawStr("abctrue"))

    # "abc" + false is "abcfalse"
    ert(plus(RawStr("abc"), Boolean(False)) == RawStr("abcfalse"))


############################################################################
# end.

print(f"[{passed}/{total}] passed")
if passed == total:
    print("all ok")
else:
    print("some asserts failed!")
