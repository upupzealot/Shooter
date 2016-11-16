local assert = assert
local sqrt, cos, sin = math.sqrt, math.cos, math.sin

local vector = {}
vector.__index = vector

local function new(x,y)
  local v = {x = x or 0, y = y or 0}
  setmetatable(v, vector)
  return v
end

local function isvector(v)
  return getmetatable(v) == vector
end

function vector:clone()
  return new(self.x, self.y)
end

function vector:unpack()
  return self.x, self.y
end

function vector:__tostring()
  return "("..tonumber(self.x)..","..tonumber(self.y)..")"
end

function vector.__unm(a)
  return new(-a.x, -a.y)
end

function vector.__add(a,b)
  assert(isvector(a) and isvector(b), "Add: wrong argument types (<vector> expected)")
  return new(a.x+b.x, a.y+b.y)
end

function vector.__sub(a,b)
  assert(isvector(a) and isvector(b), "Sub: wrong argument types (<vector> expected)")
  return new(a.x-b.x, a.y-b.y)
end

function vector.__mul(a,b)
  if type(a) == "number" then
    return new(a*b.x, a*b.y)
  elseif type(b) == "number" then
    return new(b*a.x, b*a.y)
  else
    assert(isvector(a) and isvector(b), "Mul: wrong argument types (<vector> or <number> expected)")
    return a.x*b.x + a.y*b.y
  end
end

function vector.__div(a,b)
  assert(isvector(a) and type(b) == "number", "wrong argument types (expected <vector> / <number>)")
  return new(a.x / b, a.y / b)
end

function vector.__eq(a,b)
  return a.x == b.x and a.y == b.y
end

function vector.__lt(a,b)
  return a.x < b.x or (a.x == b.x and a.y < b.y)
end

function vector.__le(a,b)
  return a.x <= b.x and a.y <= b.y
end

function vector.permul(a,b)
  assert(isvector(a) and isvector(b), "permul: wrong argument types (<vector> expected)")
  return new(a.x*b.x, a.y*b.y)
end

function vector:lenSqr()
  return self.x * self.x + self.y * self.y
end

function vector:len()
  return sqrt(self:lenSqr())
end

function vector.dist(a, b)
  assert(isvector(a) and isvector(b), "dist: wrong argument types (<vector> expected)")
  return (b-a):len()
end

function vector:normalize_inplace()
  local l = self:len()
  self.x, self.y = self.x / l, self.y / l
  return self
end

function vector:normalized()
  return self / self:len()
end

function vector:directionalize()
  local l = self:len()
  if l == 0 then
    return self
  else
    return self / self:len()
  end
end

--added for codea
function vector:normalize()
  return self / self:len()
end

function vector:rotate_inplace(phi)
  local c, s = cos(phi), sin(phi)
  self.x, self.y = c * self.x - s * self.y, s * self.x + c * self.y
  return self
end

function vector:rotated(phi)
  return self:clone():rotate_inplace(phi)
end

-- added for codea
function vector:rotate(phi)
  return self:clone():rotate_inplace(phi)
end

function vector:perpendicular()
  return new(-self.y, self.x)
end

function vector:projectOn(v)
  assert(isvector(v), "invalid argument: cannot project onto anything other than a vector")
  return (self * v) * v / v:lenSqr()
end

function vector:mirrorOn(other)
  assert(isvector(other), "invalid argument: cannot mirror on anything other than a vector")
  return 2 * self:projectOn(other) - self
end

function vector:cross(other)
  assert(isvector(other), "cross: wrong argument types (<vector> expected)")
  return self.x * other.y - self.y * other.x
end

-- added for codea
-- like in mul
function vector:dot(other)
  assert(isvector(other), "dot: wrong argument types (<vector> expected)")
  return self.x * other.x + self.y * other.y
end

function vector:angleBetween(other)
  assert(isvector(other), "angleBetween: wrong argument types (<vector> expected)")
  local alpha1 = math.atan2(self.y, self.x)
  local alpha2 = math.atan2(other.y, other.x)
  return alpha2 - alpha1
end

-- added for codea
function vec2(x,y)
  return new(x,y)
end