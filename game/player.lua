require 'game.gameobject'

Player = GameObject:subclass('Player')

function Player:initialize(pos)
 GameObject.initialize(self, 'assets/dude.png', pos)
 self.velocity = Vector()
 self.velocity.x = 100
 self.acceleration = Vector()
 self.acceleration = Vector(0, gravity) 
 self.jumpForce = 20 -- Player's starting velocity on a jump.
 self.slideTimer = 0
 self.maxSlideTimer = 1
 self.sliding = false
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
  
end

function Player:jump()
  self.velocity.y = self.velocity.y + self.jumpForce
end

function Player:slide()
  self.rotation = math.pi/2
  self.sliding = true
end

function Player:unslide()
  self.rotation = 0
  self.sliding = false
  self.slideTimer = 0
end