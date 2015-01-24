require 'game.gameobject'

Player = GameObject:subclass('Player')

function Player:initialize(pos)
 GameObject.initialize(self, 'assets/dude.png', pos)
 self.velocity = Vector()
 self.acceleration = Vector()
 self.acceleration = Vector(0, gravity) 
 self.jumpForce = 20 -- Player's starting velocity on a jump.
 self.slideTimer = 0
 self.maxSlideTimer = 1000
 self.sliding = false
end

function Player:update(dt)
  self.position = self.position + self.velocity*dt
  self.velocity = self.velocity + self.acceleration*dt
  if sliding
  then
    slideTimer = slideTimer + dt
  end
  if sliderTimer > maxSlideTimer
  then
    self:unslide()
  end
  
end

function Player:jump()
  self.velocity.y = self.velocity.y + self.jumpForce
end

function Player:slide()
  self.rotation = math.pi
  self.sliding = true
end

function Player:unslide()
  self.rotation = 0
  self.sliding = false
  self.slideTimer = 0
end