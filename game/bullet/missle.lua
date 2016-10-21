Missle = class(Bullet, 'Missle')

function Missle:init(gun)
  Bullet.init(self, gun)
  
  self.navigator = Navigator(self)
  self.av = math.pi / 3
end

function Missle:update(dt)
  self.navigator:navigate(dt)
  Bullet.update(self, dt)
end