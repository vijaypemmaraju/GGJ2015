require 'game.gameobject'

Player = GameObject:subclass('Player')

function Player:initialize(pos)
 GameObject.initialize(self, 'assets/dude.png', pos)
 self.velocity = Vector()
end
