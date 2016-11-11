Player = class(Character, "Player")

function Player:init(pos)
  Character.init(self, pos)
  
  --self.gun = Gun(self)
  --self.gun = Pistol(self)
  --self.gun = ShotGun(self)
  --self.gun = MachineGun(self)
  --self.gun = MissleGun(self)
  --self.gun = PlasmaGun(self)
  self.gun = LaserGun(self)
  
  self.gun.aimer = TowardsMouseNavigator(self.gun, {nav_key = 'direction'})
  --self.gun.aimer = NearestNavigator(self.gun)

  self.navigator = KeyboardNavigator(self, {nav_key = 'direction'})
  self.speed = 100
  self.direction = vec2(0, 0)
  self.mover = Mover(self)
end

function Player:act(dt)
  self:shoot(dt)
end


function Player:shoot(dt)
  local gun = self.gun
  
  gun:aim()
  
  if gun.can_shoot then
    gun:processShoot(dt)
  else
    gun:processReload(dt)
  end
end