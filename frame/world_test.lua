local TestWorld = class(World)
function TestWorld:init()
  self._base.init(self)
  printt(self)
  assert(self:countActors() == 0)
  self:addActor(Actor())
  assert(self:countActors() == 1)
end


local TestActor = class(Actor, 'TestActor')
function TestActor:init()
  self._base.init(self)
end


local world = TestWorld()
local actor = TestActor()
world:addActor(actor)
assert(world:countActors() == 2)
assert(world:countActors('Actor') == 2)
assert(world:countActors('TestActor') == 1)

world:addActor(actor)
assert(world:countActors() == 2)
assert(world:countActors('Actor') == 2)
assert(world:countActors('TestActor') == 1)

world:removeActor(actor)
assert(world:countActors() == 1)
assert(world:countActors('Actor') == 1)
assert(world:countActors('TestActor') == 0)