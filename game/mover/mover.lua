Mover = class('Mover')

function Mover:init(owner, option)
  scopy(self, option)
  self.owner = owner
end

function Mover:move(dt)
  local owner = self.owner
  owner.pre_pos = owner.pos
  owner.pos = owner.pos + owner.direction * owner.speed * dt
end