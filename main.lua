require('preload')

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local mouse = {
  x = width / 2,
  y = height / 2
}

local ball = {
  x = width / 2,
  y = height / 2
}

function love.mousepressed(x, y, button, istouch)
  if button == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
    mouse.x = x
    mouse.y = y
  end
end

function love.draw()
  ball.x = mouse.x
  ball.y = mouse.y
  love.graphics.ellipse('fill', ball.x, ball.y, 15, 15)
end