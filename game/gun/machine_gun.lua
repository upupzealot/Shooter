MachineGun = class(Gun, 'MachineGun')

function MachineGun:init(owner)
  local option = {
    cap = 30,
    interval = .15,
    scattering = 20,
    reload = 2,
    bullet_speed = 2000
  }
  Gun.init(self, owner, option)
end

function MachineGun:getBullet()
  return GunBullet(self)
end