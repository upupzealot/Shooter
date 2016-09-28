require('preload')

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local world = World()
world:addActor(Player(vec2(width / 2, height / 2)))