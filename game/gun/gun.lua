Gun = class('Gun')

local default_option = {
  cap = 30,             -- 弹夹容量
  clip = 30,            -- 当前装弹量
  interval = 1,         -- 射击间隔
  reload = 5,           -- 换弹间隔
  scattering = 0,       -- 准星抖动
  bullet_speed = 200   -- 子弹速度
}

function Gun:init(owner, option)
  self.owner = owner
  
  local opt = scopy(default_option)
  scopy(opt, option)
  opt.clip = opt.cap
  scopy(self, opt)
  
  self.pool = {}
  self.can_shoot = true
  
  self.shoot_count = self.interval
  self.reload_count = self.reload
end

function Gun:aim(dt)
  if self.aimer then
    self.pos = self.owner.pos
    self.world = self.owner.world
    self.aimer:navigate(dt)
  end
end

function Gun:processShoot(dt)
  if self.shoot_count < self.interval then
    self.shoot_count = self.shoot_count + dt
  end
  
  if self.shoot_count >= self.interval then
    if love.mouse.isDown(1) then
      self.shoot_count = self.shoot_count - self.interval
      self.shoot_count = math.min(self.shoot_count, self.interval / 2)
      self:shoot()
      
      self.clip = self.clip - 1
      if self.clip == 0 then
        self.can_shoot = false
        self.reload_count = self.reload_count
      end
    end
  end
end

function Gun:processReload(dt)
  self.reload_count = self.reload_count - dt
  if self.reload_count <= 0 then
    self.reload_count = self.reload
    self.clip = self.cap
    self.can_shoot = true
  end
end

function Gun:shoot()
  local bullet = self:getBullet()
  bullet:config(self)
  self:config(bullet)
  self.owner.world:addActor(bullet)
end

function Gun:getBullet()
  if #self.pool == 0 then
    return self:generateBullet()
  else
    return table.remove(self.pool)
  end
end

function Gun:config(bullet)
  bullet.direction = bullet.direction:rotate(math.rad((-0.5 + math.random()) * self.scattering))
  
  bullet.speed = self.bullet_speed
end

function Gun:generateBullet()
  return Bullet(self)
  --return GunBullet(self)
end

function Gun:recycle(bullet) -- 这里仍需要移动元素，可以优化
  bullet.active = false
  bullet.world:removeActor(bullet)
  table.insert(self.pool, bullet)
end