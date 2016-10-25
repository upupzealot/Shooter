Bullet = class(Unit, 'Bullet')

Bullet.mesh = nil

function Bullet:init(gun)
  Actor.init(self, gun.owner.pos)
  
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

function Bullet:hit() -- TODO 这里还需要考虑多个目标先击中哪个
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
  self.finished = true
end

function Bullet:recycle()
  self.gun:recycle(self)
end

function Bullet:draw()
  local pos = self.pos
  love.graphics.ellipse('fill', pos.x, pos.y, 5, 5, 12)
end