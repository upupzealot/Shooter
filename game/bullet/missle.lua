Missle = class(Bullet, 'Missle')

local img=love.graphics.newImage("plasma.png")

function Missle:init(gun)
  Bullet.init(self, gun)
  
  self.navigator = Navigator(self, {nav_key = 'direction'})
  self.av = math.pi / 1.7
  self.mover = Mover(self)

  local ps = love.graphics.newParticleSystem(img, 32)
  ps:setParticleLifetime(.3)
  ps:setSizes(.5, .4)
  ps:setColors(255, 255, 255, 255, 255, 255, 255, 0)
  ps:setEmissionRate(64)
  self.ps = ps

  self.damage = 100
end

function Missle:config(gun)
  Bullet.config(self, gun)
  self.finished = false
  self.ps:reset()
  self.ps:start(64)
end

function Missle:onOutOfBound()
  self.finished = true
  self.ps:stop()
end

function Missle:onHit(enemy)
  Bullet.onHit(self, enemy)
  self.ps:stop()
end

function Missle:isDone()
  return self.ps:getCount() == 0
end

function Missle:always(dt)
  self.ps:setPosition(self.pos.x, self.pos.y)
  self.ps:update(dt)
end

function Missle:draw()
  --Bullet.draw(self)
  love.graphics.draw(self.ps, 0, 0)
end