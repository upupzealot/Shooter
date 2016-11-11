TowardsMouseNavigator = class(Navigator, 'TowardsMouseNavigator')

function TowardsMouseNavigator:navigate(dt)
  local mouse = vec2(love.mouse.getX(), love.mouse.getY())
  if mouse == self.owner.pos then
    return --self.owner[self.nav_key] = vec2(0, 0)
  end
  return (mouse - self.owner.pos):normalize()
end