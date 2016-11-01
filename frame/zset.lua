--------------------
-- zet 有序集合
--------------------
zset = class()

function zset:init()
  local index = {}
  function self:add( value )
    if not index[value] then
      rawset(self, #self + 1, value)
      index[value] = #self
    end
  end

  function self:indexOf( value )
    return index[value]
  end

  function self:remove( value )
    local i = index[value]
    if not i then
      return nil
    end

    index[value] = nil
    local length = #self
    if i ~= length then
      for n = i, length - 1 do
        local next = rawget(self, n + 1)
        rawset(self, n, next)
        index[next] = n
      end
      rawset(self, length, nil)
    else
      rawset(self, i, nil)
      index[value] = nil
    end
  end

  local mt = {}
  function mt:__newindex( i, k )
    error("index set no longer supported. use 'add' and 'remove' function instead.")
  end
  setmetatable(self, mt);
end