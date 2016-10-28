PlasmaGun = class(Gun, 'PlasmaGun')

function PlasmaGun:init(owner)
  local option = {
    cap = 6,
    interval = 1.8,
    reload = 2.5,
    bullet_speed = 200
  }
  Gun.init(self, owner, option)
end

function PlasmaGun:generateBullet()
  return Plasma(self)
end