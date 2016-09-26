--------------------
-- 为Lua提供类、继承等概念
--------------------
class = function(base, classname, init)
  local c = {}  -- a new class instance

  if type(base) == 'table' then
    -- shallow copy of the base class!
    for i, v in pairs(base) do
      c[i] = v
    end

    if type(classname) == 'function' then
      init = classname
      classname = nil
    else
      classname = (type(classname) == 'string') and classname
      init = ((type(init) == 'function') or (type(init) == 'nil')) and init
    end
  elseif type(base) == 'string' then
    init = ((type(classname) == 'function') or (type(classname) == 'nil')) and classname
    classname = base
    base = nil
  elseif type(base) == 'function' then
    init = base
    classname = nil
    base = nil
  end

  c._base = base
  -- the class will be the metatable for all its objects,
  -- and they will look up their methods in it.
  c.__index = c

  -- expose a constructor which can be called by <classname>(<args>)
  local mt = {}
  mt.__call = function(class_tbl, ...)
    local obj = {}
    setmetatable(obj, c)
    if class_tbl.init then
      class_tbl.init(obj, ...)
    else
      -- make sure that any stuff from the base class is initialized!
      if base and base.init then
        base.init(obj, ...)
      end
    end
    return obj
  end
  c.init = init

  c._classname = classname or (base and base._classname) or c._classname
  c._classes = {} or c._classes
  if c._classname then
    table.insert(c._classes, c._classname)
  end
  
  c.is_a = function (self, klass)
    local m = getmetatable(self)
    while m do
      if m == klass then return true end
      m = m._base
    end
    return false
  end
  setmetatable(c, mt)
  return c
end