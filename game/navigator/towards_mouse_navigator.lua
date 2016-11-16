TowardsMouseNavigator = class(Navigator, 'TowardsMouseNavigator')

function TowardsMouseNavigator:navigate(dt)
  local mouse = vec2(love.mouse.getX(), love.mouse.getY())
  self.direction = (mouse - self.owner.pos):directionalize()
end