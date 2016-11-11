Navigator = class('Navigator')

local default_option = {
  weight = 1
}

function Navigator:init(owner, option)
  scopy(self, default_option)
  scopy(self, option)
  self.owner = owner
end

function Navigator:update(dt)
  local direction = self:navigate(dt)
  if self.nav_key then
    self.owner[self.nav_key] = direction
  end
end

function Navigator:navigate(dt)
  local owner = self.owner
  local emenies = owner.world:getActors('Enemy')
  if emenies and #emenies > 0 then
    table.sort(emenies, function(a, b)
      return a.pos:dist(owner.pos) < b.pos:dist(owner.pos)
    end)
    local enemy = emenies[1]

    local direction = owner[self.nav_key]
    local aim_direction = enemy.pos - owner.pos

    local sign = math.sign(direction:cross(aim_direction))
    local new_direction = direction:rotate(owner.av * dt * sign)
    
    if math.sign(new_direction:cross(aim_direction)) ~= sign then
      return aim_direction:normalize()
    else
      return new_direction
    end
  else
    return vec2(0, 0)
  end
end