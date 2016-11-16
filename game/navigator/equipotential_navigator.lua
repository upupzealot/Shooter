EquipotentialNavigator = class(Navigator, 'EquipotentialNavigator')

function EquipotentialNavigator:init(owner, option)
  Navigator.init(self, owner, option)
  self.filters = {
    DistanceFilter(owner, {
      max_dis = option.max_dis,
      min_dis = option.min_dis
    })
  }
end

function EquipotentialNavigator:navigate(dt)
  local owner = self.owner
  local units = owner.world:getActors(self.target_class)

  if self.filters and #self.filters > 0 then
    for i, filter in ipairs(self.filters) do
      units = filter:filt(units)
    end
  end

  if units and #units > 0 then
    local result_direction = vec2(0, 0)
    for i, unit in ipairs(units) do
      local unit_2_owner = self.owner.pos - unit.pos
      local direction = unit_2_owner:directionalize()
      direction = direction * self:calcWeight(unit_2_owner:len())
      result_direction = result_direction + direction
    end
    self.direction = result_direction
  else
    self.direction = vec2(0, 0)
  end
end

function EquipotentialNavigator:calcWeight(distance)
  distance = math.max(self.min_dis, distance)
  distance = math.min(self.max_dis, distance)
  local dis_factor = (distance - self.min_dis) / (self.max_dis - self.min_dis)
  local weight_factor = dis_factor ^ self.pow
  return self.min_weight + weight_factor * (self.max_weight - self.min_weight)
end