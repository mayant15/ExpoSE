from z3 import *

s = Solver()
s.set(":mbqi", False)
s.set(":auto_config", False)
set_param(proof=True)

JSValue = DeclareSort('JSValue')
Null = Const('Null', JSValue)
strictEqual = Function('strictEqual', JSValue, JSValue, BoolSort())
type_ = Function('type', JSValue, IntSort())

onc = OnClause(s, print)

x, y = Consts('x y', JSValue)

s.add(ForAll(x, (type_(x) == 0) == (x == Null), patterns=[]))
s.add(ForAll([x, y], Implies(strictEqual(x, y), type_(x) == type_(y)), patterns=[
    strictEqual(x, y)
    ]))

# s.add(Not(Implies(strictEqual(x, Null), x == Null)))
s.add(Implies(strictEqual(x, Null), x == Null))

print(s.sexpr())

print(s.check())
