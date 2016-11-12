Bullet = class(Unit, 'Bullet')

Bullet.mesh = nil

function Bullet:init(gun)
  Unit.init(self, gun.owner.pos)
  
  self.gun = gun
  self.color = gun.owner.color
  self.mover = Mover(self)
end

function Bullet:config(gun)
  self.pos = gun.owner.pos
  
  self.direction = gun.direction
  self.pre_pos = self.pos - self.direction
  
  self.active = true
  self.finished = false
end

function Bullet:act(dt)
  self:hit()
end

function Bullet:hit()
  local enemies = self.world:getActors('Enemy')
  local enemy, hit_point = self:raycast(enemies, self.direction)
  if enemy and (hit_point - self.pos):dot(hit_point - self.pre_pos) <= 0 then
    self.pos = hit_point
    self:onHit(enemy)
  end
end

function Bullet:onHit(enemy)
  self.finished = true
end

function Bullet:recycle()
  self.gun:recycle(self)
end

function Bullet:draw()
  local pos = self.pos
  love.graphics.ellipse('fill', pos.x, pos.y, 5, 5, 12)
end