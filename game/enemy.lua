Enemy = class(Character, 'Enemy')

function Enemy:init(pos)
  Character.init(self, pos)

  self.color = {r = 255, g = 125, b = 125}
end