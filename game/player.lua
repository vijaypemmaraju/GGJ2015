require 'game.gameobject'

Player = GameObject:subclass('Player')

function Player:initialize(pos)
 GameObject.initialize(self, 'assets/player.png', pos)
 self.velocity = Vector()
 self.velocity.x = 100
 self.acceleration = Vector(0,gravity)
 self.jumpForce = -600 -- Player's starting velocity on a jump.
 self.slideTimer = 0
 self.maxSlideTimer = 1
 self.sliding = false
 self.grounded = true
end

function Player:update(dt)
  self.position = self.position + self.velocity*dt
  self.velocity = self.velocity + self.acceleration*dt
  if self.sliding then
    self.slideTimer = self.slideTimer + dt
  end
  if self.slideTimer >= self.maxSlideTimer then
    self:unslide()
  end
  
  -- DEBUG FLOOR SINCE NO COLLISON ATM, REMOVE LATER!!! --
  if self.position.y >= 400 then
    self.position.y = 400
    self.grounded = true
    if self.velocity.y > 0 then
      self.velocity.y = 0
    end
  else
    self.grounded = false
  end
  
  
  -- END DEBUG -- 
end

function Player:jump()
  if self.grounded then
    self.velocity.y = self.velocity.y + self.jumpForce
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
end