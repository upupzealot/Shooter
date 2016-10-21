ShotGun = class(Gun, 'ShotGun')

function ShotGun:init(owner)
  local option = {
    cap = 6,
    interval = 1,
    scattering = 26,
    reload = 2,
    bullet_num = 8,
    bullet_speed = 2000
  }
  Gun.init(self, owner, option)
end

function ShotGun:shoot()
  for i = 1, self.bullet_num do
    Gun.shoot(self)
  end
end

function ShotGun:config(bullet)
  Gun.config(self, bullet)
  bullet.speed = bullet.speed * (0.9 + math.random() * 0.2) 
end

function ShotGun:generateBullet()
  return GunBullet(self)
end