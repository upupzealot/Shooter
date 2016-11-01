NearestNavigator = class(Navigator, 'NearestNavigator')

local default_option = {
  target_class = 'Enemy',
  direction_type = 'forward'
}

function NearestNavigator:init(owner, option)
  scopy(self, default_option)
  scopy(self, option)
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
      self.owner[self.nav_key] = -direction
    else
      self.owner[self.nav_key] = direction
    end
  end
end