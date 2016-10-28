Plasma = class(Bullet, 'Plasma')

local img=love.graphics.newImage("plasma.png")

function Plasma:init(gun)
  Bullet.init(self, gun)
  
  self.mover = Mover(self)

  local ps = love.graphics.newParticleSystem(img, 32)
  ps:setParticleLifetime(.3)
  ps:setSizes(.5, .4)
  ps:setColors(255, 255, 255, 255, 255, 255, 255, 0)
  ps:setEmissionRate(64)
  self.ps = ps
end

function Plasma:config(gun)
  Bullet.config(self, gun)
  self.finished = false
  self.ps:reset()
  self.ps:start(64)
end

function Plasma:onOutOfBound()
  self.finished = true
  self.ps:stop()
end

function Plasma:onHit()
  self.world:addActor(Explode(self.pos))
  self.finished = true
  self.ps:stop()
end

function Plasma:isDone()
  return self.ps:getCount() == 0
end

function Plasma:always(dt)
  self.ps:setPosition(self.pos.x, self.pos.y)
  self.ps:update(dt)
end

function Plasma:draw()
  love.graphics.draw(self.ps, 0, 0)
end