LaserGun = class(GunContinuous, 'LaserGun')

function LaserGun:init(owner)
  local option = {}

  GunContinuous.init(self, owner, option)
end

function GunContinuous:onFireStart()
  print('fire start')
  --TODO Override
end

function GunContinuous:shoot(amount)
  print('shoot'..self.clip)
  --TODO Override
end

function GunContinuous:onFireStop()
  print('fire stop')
  --TODO Override
end