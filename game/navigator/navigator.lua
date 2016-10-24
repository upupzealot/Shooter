Navigator = class('Navigator')

function Navigator:init(owner, option)
  scopy(self, option)
  self.owner = owner
end

function Navigator:navigate(dt)
  local emenies = self.owner.world:getActors('Enemy')
  if emenies and #emenies > 0 then
    table.sort(emenies, function(a, b)
      return a:dist(self.owner.pos) - b:dist(self.owner.pos)
    end)
    local enemy = emenies[1]

    local direction = self.owner.direction
    local aim_direction = enemy.pos - self.owner.pos

    local sign = math.sign(direction:cross(aim_direction))
    local new_direction = direction:rotate(self.owner.av * dt * sign)
    
    if math.sign(new_direction:cross(aim_direction)) ~= sign then
      self.owner.direction = aim_direction:normalize()
    else
      self.owner.direction = new_direction
    end
  end
end