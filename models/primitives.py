from z3 import Solver, DeclareSort, Function, Consts, IntSort, BoolSort, Implies, ForAll, MultiPattern, unknown, And, Or, Exists, Not, OnClause, set_param, unsat, Const

print_logs = False
# add_null = True
# add_undef = True
# add_number = True
# add_boolean = True
# add_string = False
# add_strictEq = True
# add_plus = True

############################################################################
# Definitions

JSValue = DeclareSort('JSValue')
Null, Undefined, TypeError_ = Consts(['Null', 'Undefined', 'TypeError'], JSValue)
type_ = Function('type', JSValue, IntSort())
Number = Function('Number', IntSort(), JSValue)
Boolean = Function('Boolean', BoolSort(), JSValue)

i, j = Consts('i j', IntSort())
x, y = Consts('x y', JSValue)
b, c = Consts('a b', BoolSort())

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
if print_logs:
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
b, c = Consts('b c', BoolSort())
axiom(ForAll([b, c], Implies(Boolean(b) == Boolean(c), b == c), patterns=[
    MultiPattern(Boolean(b), Boolean(c))
    ]))

############################################################################
# Type tag for values

# type(x) \in {0, 1, 2, 3, 4}
x, y = Consts('x y', JSValue)
axiom(ForAll(x, And(type_(x) >= 0, type_(x) <= 4), patterns=[type_(x)]))

#  forall x: JSValue :: {type(x)} type(x) == 0 <==> x == Null
axiom(ForAll(x, (type_(x) == 0) == (x == Null), patterns=[type_(x)]))

#  forall x: JSValue :: {type(x)} type(x) == 1 <==> x == Undefined
axiom(ForAll(x, (type_(x) == 1) == (x == Undefined), patterns=[type_(x)]))

# forall i: Int :: {type(Number(i))} type(Number(i)) == 2
# forall x: JSValue :: {type(x)} type(x) == 2 ==> exists i: Int :: x == Number(i)
axiom(ForAll(i, type_(Number(i)) == 2, patterns=[type_(Number(i))]))
axiom(ForAll(x, Implies(type_(x) == 2, Exists(i, x == Number(i))), patterns=[type_(x)]))

# type(x) == 3 iff x is a Boolean
axiom(ForAll(b, type_(Boolean(b)) == 3, patterns=[type_(Boolean(b))]))
axiom(ForAll(x, Implies(type_(x) == 3, Exists(b, x == Boolean(b))), patterns=[type_(x)]))

# type(x) == 4 iff x == TypeError()
axiom(ForAll(x, (type_(x) == 4) == (x == TypeError_), patterns=[type_(x)]))

############################################################################
# Utility functions to extract values out of the model. Type mismatches are
# not defined (TODO)

toNumber = Function('toNumber', JSValue, IntSort())
toBoolean = Function('toBoolean', JSValue, BoolSort())

axiom(ForAll(i, toNumber(Number(i)) == i, patterns=[toNumber(Number(i))]))
axiom(ForAll(b, toBoolean(Boolean(b)) == b, patterns=[toBoolean(Boolean(b))]))

############################################################################
# `+` operator

plus = Function('addition', JSValue, JSValue, JSValue)

# Works as expected with numbers
axiom(ForAll([i, j], plus(Number(i), Number(j)) == Number(i + j), patterns=[
    plus(Number(i), Number(j))
    ]))

# TypeError if any one the inputs is not a number
axiom(ForAll([x, y], Implies(Or(type_(x) != 2, type_(y) != 2), plus(x, y) == TypeError_), patterns=[
    plus(x, y)
    ]))

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

############################################################################
# TESTS
############################################################################

s.add(axioms)

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
ert(Implies(strictEqual(plus(x, Number(3)), Number(45)), x == Number(42)))

# === for booleans
ert(strictEqual(Boolean(True), Boolean(True)))
ert(Not(strictEqual(Boolean(False), Boolean(True))))
ert(Not(strictEqual(Boolean(True), Boolean(False))))
ert(strictEqual(Boolean(False), Boolean(False)))

# === for differing types
ert(Not(strictEqual(Boolean(True), Number(1))))

print(f"[{passed}/{total}] passed")
if passed == total:
    print("all ok")
else:
    print("some asserts failed!")
