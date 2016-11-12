DistanceFilter = class(Filter, 'DistanceFilter')

function DistanceFilter:init(owner, option)
  Filter.init(self, owner, option)
end

function DistanceFilter:pass(unit)
  if unit == self then
    return false
  end

  if self.max_dis and self.owner.pos:dist(unit.pos) >= self.max_dis then
    return false
  end

  if self.min_dis and self.owner.pos:dist(unit.pos) < self.min_dis then
    return false
  end

  return true
end