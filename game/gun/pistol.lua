Pistol = class(Gun, 'Pistol')

function Pistol:init(owner)
  local option = {
    cap = 6,
    interval = .8,
    scattering = 8,
    reload = 1.5,
    bullet_speed = 2000
  }
  Gun.init(self, owner, option)
end

function Pistol:generateBullet()
  return GunBullet(self)
end