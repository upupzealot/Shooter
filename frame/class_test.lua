local X = class()
assert(X._classname == nil)

local A = class('A')
assert(A._classname, 'A')

local a = A()
assert(a._classname, 'A')
--assert(a:is_a(A))

local B = class(A)
assert(B._classname, 'A')

local C = class(A, 'C')
local c = C();
assert(c._classname, 'C')
assert(c:is_a(C))
assert(c:is_a(A))