Filter = class('Filter')

function Filter:init(owner, option)
  self.owner = owner
  scopy(self, option)
end

function Filter:filt(unit)
  -- 返回一个 boolean 表示是否 pass
  return true
end