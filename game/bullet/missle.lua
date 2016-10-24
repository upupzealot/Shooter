Missle = class(Bullet, 'Missle')

local img=love.graphics.newImage("missle-tail.png")

function Missle:init(gun)
  Bullet.init(self, gun)
  
  self.navigator = Navigator(self)
  self.av = math.pi / 1.7

  local ps = love.graphics.newParticleSystem(img, 32)
  ps:setParticleLifetime(.3)
  ps:setSizes(.5, .2)
  ps:setColors(255, 255, 255, 255, 255, 255, 255, 0)
  ps:setEmissionRate(64)
  self.ps = ps
end

function Missle:update(dt)
  if not self.finished then
    self.navigator:navigate(dt)

    self.pre_pos = self.pos
    local pos = self.pos + self.direction * self.speed * dt
    self.pos = pos
    
    self:hit()
    
    if pos.x < 0 or pos.x > WIDTH or pos.y < 0 or pos.y > HEIGHT then
      self.finished = true
      self.ps:stop()
    end
  else -- self.finished == true
    if self.ps:getCount() == 0 then
      self:recycle()
    end
  end
  
  self.ps:setPosition(self.pos.x, self.pos.y)
  self.ps:update(dt)
end

function Missle:onHit()
  self.world:addActor(Explode(self.pos))
  self.finished = true
  self.ps:stop()
end

function Missle:render()
  --Bullet.render(self)
  love.graphics.draw(self.ps, 0, 0)
end

function Missle:config(gun)
  Bullet.config(self, gun)
  self.finished = false
  self.ps:reset()
  self.ps:start(64)
end