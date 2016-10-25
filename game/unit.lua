Unit = class(Actor, "Unit")

function Unit:render()
  love.graphics.push('all')
    if self.color then
      love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    end
    if self.draw then
      self:draw()
    end
  love.graphics.pop()
end

function Unit:update(dt)
  if not self.finished then
    self:navigate(dt)
    self:move(dt)
    
    if self.act then
      self:act(dt)
    end
    
    if self:isOutOfBound() then
      self:onOutOfBound()
    end
  end

  if self.finished then
    if self.finishedAct then
      self:finishedAct(dt)
    end
    if self:isDone() then
      self:done()
    end
  end
  
  if self.always then
    self:always(dt)
  end
end

function Unit:navigate(dt)
  if self.navigator then
    self.navigator:navigate(dt)
  end
end

function Unit:move(dt)
  if self.mover then
    self.mover:move(dt)
  end
end

function Unit:isOutOfBound()
  local pos = self.pos
  return pos.x < 0 or pos.x > WIDTH or pos.y < 0 or pos.y > HEIGHT
end

function Unit:onOutOfBound()
  self.finished = true
end

function Unit:isDone()
  return true
end

function Unit:done()
  self:recycle()
end

function Unit:recycle()
  self.world:removeActor(self)
end