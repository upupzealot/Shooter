Bullet = class(Actor, 'Bullet')

Bullet.mesh = nil

function Bullet:init(gun)
  Actor.init(self, gun.owner.pos)
  
  self.gun = gun
  self.color = gun.owner.color
end

function Bullet:config(gun)
  self.pos = gun.owner.pos
  
  self.direction = gun.direction
  self.pre_pos = self.pos - self.direction
  
  self.active = true
end

function Bullet:update(dt)
  self.pre_pos = self.pos
  local pos = self.pos + self.v * dt
  self.pos = pos
    
  self:hit()
    
  if pos.x < 0 or pos.x > WIDTH or pos.y < 0 or pos.y > HEIGHT then
    self:recycle()
  end
end

function Bullet:hit()
  local enemies = self.world:getActors('Enemy')
  for i, enemy in ipairs(enemies) do
    local vec_to_enemy = enemy.pos - self.pre_pos
    local dis_foot_point = vec_to_enemy:dot(self.direction)
    if dis_foot_point > 0 then
      local min_dis = (vec_to_enemy:lenSqr() - dis_foot_point ^ 2) ^ 0.5
      if min_dis < enemy.size then
        local foot_point = self.pre_pos + dis_foot_point * self.direction
        local off_set = (enemy.size ^ 2 - min_dis ^ 2) ^ 0.5
        local bound_point = foot_point - self.direction * off_set
        if (bound_point - self.pos):dot(self.direction) <= 0 then
          self.pos = bound_point
          self:onHit(enemy)
        end
      end
    end
  end
end

function Bullet:onHit(enemy)
  self:recycle()
end

function Bullet:recycle()
  self.gun:recycle(self)
end

function Bullet:render()
  local pos = self.pos
  --love.graphics.ellipse('fill', pos.x, pos.y, 5, 5, 5)
  love.graphics.arc('fill', pos.x, pos.y, 5, 0, 2 * math.pi)
end