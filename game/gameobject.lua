
GameObject = class('GameObject')

function GameObject:initialize(filename, pos, rot, scl, orig, color)
  self._filename = filename
  self.texture = util.loadTexture(filename)
  self.position = pos or Vector()
  self.rotation = rot or 0
  self.scale = scl or Vector(1,1)
  self.origin = orig or Vector(0.5, 0.5)
  self.color = color or Color(255,255,255,255)
end

function GameObject:draw()
  local x = self.position.x
  local y = self.position.y
  love.graphics.setColor(self.color:unpack())
  love.graphics.draw(self.texture, x,y, self.rotation, self.scale.x, self.scale.y, self.origin.x * self.texture:getWidth(), self.origin.y *   self.texture:getHeight())
end