Filter = class('Filter')

function Filter:init(owner, option)
  self.owner = owner
  scopy(self, option)
end

function Filter:filt(units)
  local filtered_units = {}
  for i, unit in ipairs(units) do
    if self:pass(unit) then
      table.insert(filtered_units, unit)
    end
  end
  return filtered_units
end

function Filter:pass(unit)
  -- 返回一个 boolean 表示是否 pass
  return true
end