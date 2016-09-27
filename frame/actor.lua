--------------------
-- 游戏对象
--------------------
Actor = class('Actor')
Actor.UID = 1

function Actor:init(pos)
  self.id = Actor.UID
  Actor.UID = Actor.UID + 1
  
  self.pos = pos
  self.active = true
end

-- 被添加进场景后的回调
--function Actor:added()
--end
-- 逻辑步进
--function Actor:update()
--end
-- 帧渲染
--function Actor:render()
--end