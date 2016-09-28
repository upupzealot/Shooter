--------------------
-- 程序主循环
--------------------
love.update = function()
  love.graphics.setBackgroundColor(40, 40, 40)
  love.graphics.setColor(255, 255, 255)
  love.graphics.setLineWidth(4)
  
  if not World.current then
    return
  end
  
  if World.current.update then
    World.current:update()
  end
  
  for classname, actors in pairs(World.current.actors) do
    for i, actor in ipairs(actors) do
      if actor._classname == classname and actor.active and actor.update then
        actor:update()
      end
    end
  end
end

love.draw = function()
  for classname, actors in pairs(World.current.actors) do
    for i, actor in ipairs(actors) do
      if actor._classname == classname and actor.active and actor.render then
        actor:render()
      end
    end
  end
end