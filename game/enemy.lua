Enemy = class(Character, 'Enemy')

function Enemy:init(pos)
  Character.init(self, pos)
  self.color = {r = 255, g = 125, b = 125}

  --self.navigator = NearestNavigator(self, {target_class = 'Player'})
  self.navigator = GroupNavigator(self, {
    navigators = {
      EquipotentialNavigator(self, {
        filters = {
          DistanceFilter(self, {
            max_dis = 30,
            min_dis = 0
          })
        },
        max_dis = 30,
        min_dis = 0,
        max_weight = 10,
        min_weight = 0,
        pow = 2,
        weight = 10,
        one_minus = false,
        target_class = 'Enemy'
      }),
      NearestNavigator(self, {target_class = 'Player'})
    },
    nav_key = 'direction'
  })
  self.speed = 50
  self.direction = vec2(0, 0)
  self.mover = Mover(self)
end