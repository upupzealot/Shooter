EquipotentialNavigator = class(Navigator, 'EquipotentialNavigator')

function EquipotentialNavigator:init(owner, option)
  local opt = scopy(default_option)
  scopy(opt, option)
  Navigator.init(self, owner, opt)
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
      local vec = self.owner.pos - unit.pos
      vec = (unit_2_owner):normalize() * self.calcWeight(unit_2_owner:len())
      result_direction = result_direction + vec
    end
    return result_direction
  else
    return vec2(0, 0)
  end
end

function EquipotentialNavigator:calcWeight(distance)
  distance = math.max(self.min_dis, distance)
  distance = math.min(self.max_dis, distance)
  local dis_factor = (distance - self.min_dis) / (self.max_dis - self.min_dis)
  local weight_factor = dis_factor ^ self.pow
  if self.one_minus then
    weight_factor = 1 - weight_factor
  end
  return self.min_weight + weight_factor * (self.max_weight - self.min_weight)
end