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
end

function Player:act(dt)
  self:shoot(dt)
end


function Player:shoot(dt)
  local gun = self.gun
  
  local aim_pos = vec2(love.mouse.getX(), love.mouse.getY())
  gun:aim(aim_pos)
  
  if gun.can_shoot then
    gun:processShoot(dt)
  else
    gun:processReload(dt)
  end
end