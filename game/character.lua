Character = class(Actor, "Character")

function Character:init(pos)
  Actor.init(self, pos)
  
  self.color = {r = 255, g = 255, b = 255}
  self.size = 15;
end

-- 绘制一个直径为15的圆
function Character:render()
  love.graphics.push()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    love.graphics.ellipse('fill', self.pos.x, self.pos.y, self.size, self.size)
  love.graphics.pop()
end