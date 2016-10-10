Player = class(Character, "Player")

function Player:init(pos)
  Character.init(self, pos)
  
  self.gun = Gun()
  -- self.gun = Pistol(self)
  -- self.gun = ShotGun(self)
  -- self.gun = MachineGun(self)
end

function Player:update()
  if not love.mouse.isDown(1) then
    return -- not touched yet
  else
    self:shoot()
  end 
end

function Player:shoot()
  self.gun:shoot()
end