GroupNavigator = class(Navigator, 'GroupNavigator')

GroupNavigator.ZERO = vec2(0, 0)

function GroupNavigator:navigate(dt)
  local result_direction = vec2(0, 0)

  if self.navigators and #self.navigators > 0 then
    for i, navigator in ipairs(self.navigators) do
      navigator:navigate(dt)
      result_direction = result_direction + navigator.direction * navigator.weight
    end
  end
  
  self.direction = result_direction:directionalize()
end