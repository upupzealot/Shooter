MissleGun = class(Gun, 'MissleGun')

function MissleGun:init(owner)
  local option = {
    cap = 6,
    interval = 1.8,
    reload = 2.5,
    bullet_speed = 200,
    damage = 100
  }
  Gun.init(self, owner, option)
end

function MissleGun:generateBullet()
  return Missle(self)
end