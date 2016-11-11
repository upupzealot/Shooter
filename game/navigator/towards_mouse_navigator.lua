TowardsMouseNavigator = class(Navigator, 'TowardsMouseNavigator')

function TowardsMouseNavigator:navigate(dt)
  local mouse = vec2(love.mouse.getX(), love.mouse.getY())
  if mouse == self.owner.pos then
    self.direction = vec2(0, 0)
  end
  self.direction = (mouse - self.owner.pos):normalize()
end