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

function Unit:raycast(units, direction)
  local hit_dis = nil
  local hit_min = nil
  local hit_unit = nil
  function sqrt_sub(a, b)
    -- 避免在某些情况下，由于浮点运算等原因 a方 < b方
    return math.max(0, a * a - b * b) ^ .5
  end
  for i, unit in ipairs(units) do
    local vec_to_unit = unit.pos - self.pre_pos
    if vec_to_unit:len() < unit.size then
      return unit, self.pre_pos
    end
    local dis_foot_point = vec_to_unit:dot(direction)
    if dis_foot_point > 0 then
      local min_dis = sqrt_sub(vec_to_unit:len(), dis_foot_point)
      if min_dis < unit.size then
        if not hit_dis or dis_foot_point < hit_dis then
          hit_dis = dis_foot_point
          hit_min = min_dis
          hit_unit = unit
        end
      end
    end
  end

  if hit_dis then
    local foot_point = self.pre_pos + hit_dis * direction
    local off_set = sqrt_sub(hit_unit.size, hit_min)
    local bound_point = foot_point - direction * off_set
    return hit_unit, bound_point
  end
end