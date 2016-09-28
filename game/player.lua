Player = class(Character, "Player")

function Player:init(pos)
  Character.init(self, pos)
  
  --self.gun = Pistol(self)
  -- self.gun = ShotGun(self)
  -- self.gun = MachineGun(self)
end

function Player:update()
  if not love.mouse.isDown(1) then return end -- not touched yet
  
  self:shoot()
end

function Player:shoot()
  print('shoot')
end