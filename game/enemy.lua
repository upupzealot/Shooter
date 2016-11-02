Enemy = class(Character, 'Enemy')

function Enemy:init(pos)
  Character.init(self, pos)
  self.color = {r = 255, g = 125, b = 125}

  self.navigator = NearestNavigator(self, {target_class = 'Player'})
  self.speed = 50
  self.direction = vec2(0, 0)
  self.mover = Mover(self)
end