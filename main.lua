require('preload')

WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()

local world = World()
world:addActor(Player(vec2(WIDTH / 2, HEIGHT / 2)))
world:addActor(Enemy(vec2(WIDTH * 3 / 4, HEIGHT / 2)))