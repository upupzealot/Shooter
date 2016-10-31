Laser = class(Bullet, 'Laser')

function Laser:init(gun)
  Actor.init(self, gun.owner.pos)
  
  self.gun = gun
  self.color = gun.owner.color
end

function Laser:config(gun)
  self.pos = gun.owner.pos
  self.pre_pos = self.pos
  
  self.direction = gun.direction
end

function Laser:hit()
  local enemies = self.world:getActors('Enemy')
  local enemy, hit_point = self:raycast(enemies, self.direction)
  if enemy then
    self.endPoint = hit_point
    self:onHit(enemy)
  else
    self.endPoint = self.pos + self.direction * 1000
  end
end

function Laser:onHit(enemy)
  --TODO damage/reflect
end

function Laser:draw()
  love.graphics.line(self.pos.x, self.pos.y, self.endPoint.x, self.endPoint.y)
  love.graphics.ellipse('fill', self.endPoint.x, self.endPoint.y, 5, 5, 12)
end