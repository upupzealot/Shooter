Player = class(Character, "Player")

function Player:init(pos)
  Character.init(self, pos)
  
  self.gun = Gun(self)
  -- self.gun = Pistol(self)
  -- self.gun = ShotGun(self)
  -- self.gun = MachineGun(self)
end

function Player:update(dt)
  if not love.mouse.isDown(1) then
    return -- not touched yet
  else
    self:shoot(dt)
  end 
end


function Player:shoot(dt)
  local gun = self.gun
  local aim_pos = vec2(love.mouse.getX(), love.mouse.getY())
  gun:aim(aim_pos)
  --love.graphics.ellipse(aim_pos.x, aim_pos.y, 5)
  -- strokeWidth(5)
  -- line(self.pos.x, self.pos.y, CurrentTouch.x, CurrentTouch.y)
  if gun.can_shoot then
    gun:processShoot(dt)
  else
    gun:processReload(dt)
  end
end