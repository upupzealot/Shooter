Explode = class(Actor, 'Explode')

function Explode:init(pos)
  Actor.init(self, pos)

  self.size = 10
  self.alpha = 255
  self.life = .3
  self.life_counter = 0
end

function Explode:update(dt)
  self.life_counter = self.life_counter + dt
  local process = self.life_counter / self.life
  if process > 1 then
    self.world:removeActor(self)
  else
    self.size = 10 + 30 * process
    self.alpha = 255 * (1 - process) * (1 - process)
  end
end

function Explode:render()
  love.graphics.push('all')
    love.graphics.setColor(255, 255, 255, self.alpha)
    love.graphics.ellipse('fill', self.pos.x, self.pos.y, self.size, self.size, 24)
  love.graphics.pop()
end