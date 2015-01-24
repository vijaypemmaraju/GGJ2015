require 'game.gameobject'

Player = GameObject:subclass('Player')

function Player:initialize(pos)
 GameObject.initialize(self, 'assets/player.png', pos)
 self.collider = Collider:addRectangle(self.position.x, self.position.y, self.texture:getWidth(), self.texture:getHeight())
 self.velocity = Vector()
 self.velocity.x = 256
 self.acceleration = Vector(0,gravity)
 self.jumpForce = -64*gravity/self.velocity.x---(96 + 48*gravity/self.velocity.x)-- Player's starting velocity on a jump.
 self.slideTimer = 0
 self.maxSlideTimer = 0.375
 self.jumpTimer = 64/self.velocity.x * 2
 self.sliding = false
 self.grounded = false
end

function Player:update(dt)
  self.position = self.position + self.velocity*dt
  if not self.grounded then
    if self.velocity.y < 0 then
      self.velocity = self.velocity + self.acceleration*dt
    else
      self.velocity = self.velocity + self.acceleration*dt*5
    end
    
  end
  
  
  if  self.grounded and self.velocity.y > 0 then
    self.velocity.y = 0
  end
  
  
  self.velocity.y = math.min(self.velocity.y, 1000)
  if self.sliding then
    self.slideTimer = self.slideTimer + dt
  end
  if self.slideTimer >= self.maxSlideTimer then
    self:unslide()
  end
  local hitGround = false
  
  
  self.collider:moveTo(self.position.x, self.position.y)
  self.collider:setRotation(self.rotation)
  
  
  for _,tile in pairs(collisionTiles) do
         
      local collides, dx, dy = self.collider:collidesWith(tile)
     if collides then
     
        if dy < 0 then
           hitGround = true
           if  self.velocity.y > 0 and not self.grounded then
             self.position.y = self.position.y + dy + 1
             self.grounded = true

             self.velocity.y = 0
            end
            

        end
        
--        if dy > 0 and self.velocity.y  < 0 then
--          self.position.y = self.position.y + dy
--          self.velocity.y = 0
--        end
        

         -- print(dx .. ' ' .. dy)\
        if dx < -1 then
           
          self.position.x = self.position.x + dx
        end
        
     end
     
     
  end
  if not hitGround then
     self.grounded = false
  end

 
  -- DEBUG FLOOR SINCE NO COLLISON ATM, REMOVE LATER!!! --
--  if self.position.y >= 400 then
--    self.position.y = 400
--    self.grounded = true
--    if self.velocity.y > 0 then
--      self.velocity.y = 0
--    end
--  else
--    self.grounded = false
--  end
  --for 
  
  -- END DEBUG -- 
end

function Player:jump()
  if self.grounded then
    self.velocity.y = self.velocity.y + self.jumpForce
    self.grounded = false
  end
end

function Player:slide()
  self.rotation = -math.pi/2
  self.sliding = true
end

function Player:unslide()
  self.rotation = 0
  self.sliding = false
  self.slideTimer = 0
  self.grounded = false
end

function Player:moveUp()
	self.velocity.y = 500
end

function Player:moveDown()
	self.velocity.y = -500
end

function Player:moveLeft()
	self.velocity.x = -500
end

function Player:moveRight()
	self.velocity.x = 500
end

function Player:stop()
	self.velocity = Vector(0, 0)
end

function Player:delay()
end