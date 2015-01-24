require 'states.state'
require 'game.player'
cam = require 'lib.hump.camera'

camera = cam()
player = Player(Vector(50,50))

function game:initialize()
  
end

function game:init()
  
end


function game:enter(previous) -- run every time the state is entered
  state.enter(self,previous)
  --TEsound.playLooping("assets/sounds/Running in the 90's.mp3")
  
end

function game:update(dt)
  map:update(dt)
  
end

function game:draw()
  state:draw()
  camera:attach()
  map:draw()
  love.graphics.setColor(255,255,255,255)
  player:draw()
  camera:detach()
end

function game:mousepressed(x,y, btn)
end
 
     
return game