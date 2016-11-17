require('preload')

WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()

local world = World()
world:addActor(Player(vec2(WIDTH / 2, HEIGHT / 2)))
world:addActor(Enemy(vec2(WIDTH * 3 / 4, HEIGHT / 2)))
--world:addActor(Enemy(vec2(WIDTH * 3 / 4, HEIGHT / 4)))

world.generate_interval = 2
world.generate_count = 0
function world:update(dt)
  self.generate_count = self.generate_count + dt
  if self.generate_count >= self.generate_interval then
    self.generate_count = self.generate_count - self.generate_interval
    self:addActor(Enemy(vec2(WIDTH * math.random(), HEIGHT * math.random())))
  end
end