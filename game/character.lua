Character = class(Unit, "Character")

function Character:init(pos)
  Unit.init(self, pos)
  
  self.color = {r = 255, g = 255, b = 255}
  self.size = 15
  
  self.hp_max = 100
  self.hp = self.hp_max
end

-- 绘制一个直径为15的圆
function Character:draw()
  love.graphics.setLineWidth(4)
  local angle1 = math.pi * self.hp / self.hp_max
  local angle2 = -angle1
  love.graphics.arc('fill', self.pos.x, self.pos.y, self.size - 8, angle1 + math.pi / 2, angle2 + math.pi / 2, 24)
  love.graphics.ellipse('line', self.pos.x, self.pos.y, self.size - 2, self.size - 2, 24)
end

function Character:onOutOfBound()
  -- do nothing
end

function Character:dead()
  self.finished = true
  self.world:addActor(Explode(self.pos))
end