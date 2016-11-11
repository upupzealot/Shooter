NearestNavigator = class(Navigator, 'NearestNavigator')

local default_option = {
  target_class = 'Enemy',
  direction_type = 'forward'
}

function NearestNavigator:init(owner, option)
  local opt = scopy(default_option)
  scopy(opt, option)
  Navigator.init(self, owner, opt)
end

function NearestNavigator:navigate(dt)
  local owner = self.owner
  local units = owner.world:getActors(self.target_class)
  if units and #units > 0 then
    table.sort(units, function(a, b)
      return a.pos:dist(owner.pos) < b.pos:dist(owner.pos)
    end)
    local unit = units[1]

    local direction = (unit.pos - owner.pos):normalize()
    
    if direction_type == 'backward' then
      return -direction
    else
      return direction
    end
  else
    return vec2(0, 0)
  end
end