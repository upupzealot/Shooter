GroupNavigator = class(Navigator, 'GroupNavigator')

function GroupNavigator:navigate(dt)
  local result_direction = vec2(0, 0)

  if self.navigators and #self.navigators > 0 then
    for i, navigator in ipairs(self.navigators) do
      result_direction = result_direction + navigator:navigate(dt) * navigator.weight
    end
  end

  return result_direction
end