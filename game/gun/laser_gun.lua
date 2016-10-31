LaserGun = class(GunContinuous, 'LaserGun')

function LaserGun:init(owner)
  local option = {}

  GunContinuous.init(self, owner, option)
end

function LaserGun:onFireStart()
  local laser = self:getBullet()
  self.owner.world:addActor(laser)
  self:shoot()
  laser:update(0)
end

function LaserGun:shoot()
  local laser = self:getBullet()
  laser:config(self)
  self:config(laser)
end

function LaserGun:onFireStop()
  local laser = self:getBullet()
  self.owner.world:removeActor(laser)
end

function LaserGun:getBullet()
  if not self.laser then
    self.laser = Laser(self)
  end
  return self.laser
end

function LaserGun:config(laser)
  --laser.dps = laser.dps
end