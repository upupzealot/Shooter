Character = class(Unit, "Character")

function Character:init(pos)
  Unit.init(self, pos)
  
  self.color = {r = 255, g = 255, b = 255}
  self.size = 15;
end

-- 绘制一个直径为15的圆
function Character:draw()
  love.graphics.setLineWidth(4)
  love.graphics.ellipse('fill', self.pos.x, self.pos.y, self.size - 8, self.size - 8, 24)
  love.graphics.ellipse('line', self.pos.x, self.pos.y, self.size - 2, self.size - 2, 24)
end

function Character:onOutOfBound()
  -- do nothing
end