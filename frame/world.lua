--------------------
-- World 场景类
-- Actor对象存在的容器
--------------------
World = class()

function World:init()
  self.actors = {}
end

-- 向场景中添加 Actor 对象
function World:addActor(actor)
  if actor.world == nil then -- 考虑到多个 World 的情况，这里需要修改
    for i, classname in ipairs(actor._classes) do
      if not self.actors[classname] then
        self.actors[classname] = zset()
      end
      self.actors[classname]:add(actor)
    end
    
    actor.world = self
    actor:added()
  end
end

-- 场景中某一类 Actor 对象的数量
function World:countActors(classname)
  if not classname then
    for classname,actors in pairs(self.actors) do
      print(classname..':'..#actors)
    end
    return #self.actors['Actor']
  else
    return #self.actors[classname]
  end
end

-- 获取场景中制定类型的 Actor 对象
function World:getActors(classname)
  return self.actors[classname]
end

-- 移除场景中的游戏对象
function World:removeActor(actor)
  if actor.world == self then
    for i, classname in ipairs(actor.classes) do
      local actors = self.actors[classname]
      actors:remove(actor)
    end
  end
end