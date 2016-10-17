GunBullet = class(Bullet, 'GunBullet')

function GunBullet:init(gun)
  Bullet.init(self, gun)
  
  self.max_length = 500
  self.width = 2
  if not GunBullet.mesh then
    GunBullet.vertices = {
      {0, 0, 0, 0, 255, 255, 255, 255},
      {0, 0, 0, 0, 255, 255, 255, 255},
      {0, 0, 0, 0, 255, 255, 255, 255},
      {0, 0, 0, 0, 255, 255, 255, 255}
    }
    GunBullet.mesh = love.graphics.newMesh(GunBullet.vertices)
  end
end

function GunBullet:config(gun)
  Bullet.config(self, gun)

  self.tail_pos = self.pos
  self.length = 0
  self.finished = false
  
  self.color = {r = 255, g = 255, b = 255}
  self.head_alpha = 255
end

function GunBullet:update(dt)
  if not self.finished then
    local pos = self.pos + self.v * dt
    self.pos = pos
    
    self:hit()
    
    if (pos.x < 0 and self.tail_pos.x < 0)
    or (pos.x > WIDTH and self.tail_pos.x > WIDTH)
    or (pos.y < 0 and self.tail_pos.y < 0)
    or (pos.y > HEIGHT and self.tail_pos.y > HEIGHT) then
      self:recycle()
    end
  else
    self.head_alpha = self.head_alpha - (self.v:len() * dt / self.max_length) * 255
    if self.head_alpha <= 0 then
      self:recycle()
    end
  end
  
  local dis = self.pos:dist(self.tail_pos)
  if not self.finished then -- 距离决定tail_alpha
    dis = math.min(dis, self.max_length)
  else -- finished head_alpha 决定最大距离
    local alpha_dis = self.head_alpha / 255 * self.max_length
    dis = math.min(dis, alpha_dis)
  end
  self.length = dis
  self.tail_pos = self.pos - self.direction * dis
  self.tail_alpha = self.head_alpha - dis / self.max_length * 255
end

function GunBullet:onHit()
  self.world:addActor(Explode(self.pos))
  self.finished = true
end

function GunBullet:getVertices()
  GunBullet.vertices[1][1] = 0
  GunBullet.vertices[1][2] = self.width / 2
  GunBullet.vertices[1][5] = self.color.r
  GunBullet.vertices[1][6] = self.color.g
  GunBullet.vertices[1][7] = self.color.b
  GunBullet.vertices[1][8] = self.head_alpha

  GunBullet.vertices[2][1] = 0
  GunBullet.vertices[2][2] = -self.width / 2
  GunBullet.vertices[2][5] = self.color.r
  GunBullet.vertices[2][6] = self.color.g
  GunBullet.vertices[2][7] = self.color.b
  GunBullet.vertices[2][8] = self.head_alpha

  GunBullet.vertices[3][1] = -self.length
  GunBullet.vertices[3][2] = -self.width / 2
  GunBullet.vertices[3][5] = self.color.r
  GunBullet.vertices[3][6] = self.color.g
  GunBullet.vertices[3][7] = self.color.b
  GunBullet.vertices[3][8] = self.tail_alpha

  GunBullet.vertices[4][1] = -self.length
  GunBullet.vertices[4][2] = self.width / 2
  GunBullet.vertices[4][5] = self.color.r
  GunBullet.vertices[4][6] = self.color.g
  GunBullet.vertices[4][7] = self.color.b
  GunBullet.vertices[4][8] = self.tail_alpha

  return GunBullet.vertices
end

function GunBullet:render()
  local pos = self.pos
  local dis = pos:dist(self.tail_pos)
  
  love.graphics.push()
    love.graphics.translate(pos.x, pos.y)
    love.graphics.rotate(-self.direction:angleBetween(vec2(1, 0)))

    local vertices = self:getVertices()
    for i,vertex in ipairs(vertices) do
      GunBullet.mesh:setVertex(i, vertex)
    end

    love.graphics.draw(GunBullet.mesh)
  love.graphics.pop()
end