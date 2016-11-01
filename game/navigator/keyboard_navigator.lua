KeyboardNavigator = class(Navigator, 'KeyboardNavigator')

local default_option = {
  left = 'a',
  right = 'd',
  up = 'w',
  down = 's'
}

function KeyboardNavigator:init(owner, option)
  opt = scopy(default_option)
  opt = scopy(opt, option)
  Navigator.init(self, owner, opt)
end

KeyboardNavigator.ZERO = vec2(0, 0)
KeyboardNavigator.LEFT = vec2(-1, 0)
KeyboardNavigator.RIGHT = vec2(1, 0)
KeyboardNavigator.UP = vec2(0, -1)
KeyboardNavigator.DOWN = vec2(0, 1)

function KeyboardNavigator:navigate(dt)
  local direction = KeyboardNavigator.ZERO

  if love.keyboard.isDown(self.left) then
    direction = direction + KeyboardNavigator.LEFT
  end
  if love.keyboard.isDown(self.right) then
    direction = direction + KeyboardNavigator.RIGHT
  end
  if love.keyboard.isDown(self.up) then
    direction = direction + KeyboardNavigator.UP
  end
  if love.keyboard.isDown(self.down) then
    direction = direction + KeyboardNavigator.DOWN
  end

  local owner = self.owner
  if direction ~= KeyboardNavigator.ZERO and direction:len() ~= 1 then
    owner[self.nav_key] = direction:normalize()
  else
    owner[self.nav_key] = direction
  end
end