GunContinuous = class(Gun, 'GunContinuous')

local default_option = {
  cap = 100,              -- 弹夹容量
  clip = 100,             -- 当前装弹量
  fire_per_sec = 40,      -- 每秒消耗的能量
  generate_per_sec = 40,  -- 每秒充能速度
  --interval = 0,         -- 射击间隔
  --reload = 5,           -- 换弹间隔
  --scattering = 0,       -- 准星抖动
  --bullet_speed = 200    -- 子弹速度
}

function GunContinuous:init(owner, option)
  local opt = scopy(default_option)
  scopy(opt, option)

  Gun.init(self, owner, opt)
  self.firing = false

  self.interval = nil
  self.reload = nil
end

function GunContinuous:processShoot(dt)
  if self.clip > 0 and love.mouse.isDown(1) then
    if not self.firing then
      self.firing = true
      if self.onFireStart then
        self:onFireStart()
      end
    end

    local amount = self.fire_per_sec * dt
    amount = math.min(amount, self.clip)
    self.clip = self.clip - amount
    
    self:shoot(amount)
  end

  if self.clip == 0 or not love.mouse.isDown(1) then
    if self.clip == 0 then
      self.can_shoot = false
    end
    self.firing = false
    if self.onFireStop then
      self:onFireStop()
    end
  end
end

function GunContinuous:processReload(dt)
  self.clip = self.clip + self.generate_per_sec * dt
  self.clip = math.min(self.cap, self.clip)

  if self.clip == self.cap then
    self.can_shoot = true
  end
end

function GunContinuous:shoot(amount)
  --print('shoot'..self.clip)
  --TODO Override
end