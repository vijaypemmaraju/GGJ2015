require 'game.gameobject'

Player = GameObject:subclass('Player')

function Player:initialize(pos)
 GameObject.initialize(self, 'assets/dude.png', pos)
 self.velocity = Vector()
 self.acceleration = Vector()
 self.acceleration = Vector(0, gravity) 
 self.jumpForce = 20 -- Player's starting velocity on a jump.
end

function Player:update(dt)
  self.position = self.position + self.velocity*dt
  self.velocity = self.velocity + self.acceleration*dt
end

function Player:jump()
  self.velocity.y = self.velocity.y + self.jumpForce
end