Navigator = class('Navigator')

function Navigator:init(owner, option)
  scopy(self, option)
  self.owner = owner
end

function Navigator:navigate(dt)
  local owner = self.owner
  local emenies = owner.world:getActors('Enemy')
  if emenies and #emenies > 0 then
    table.sort(emenies, function(a, b)
      return a:dist(owner.pos) - b:dist(owner.pos)
    end)
    local enemy = emenies[1]

    local direction = owner.direction
    local aim_direction = enemy.pos - owner.pos

    local sign = math.sign(direction:cross(aim_direction))
    local new_direction = direction:rotate(owner.av * dt * sign)
    
    if math.sign(new_direction:cross(aim_direction)) ~= sign then
      owner.direction = aim_direction:normalize()
    else
      owner.direction = new_direction
    end
  end
end