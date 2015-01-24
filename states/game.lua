require 'states.state'
require 'game.player'
require 'game.bar'
cam = require 'lib.hump.camera'

camera = cam()
player = Player(Vector(50,50))
gravity = -10 -- Acceleration of Gravity

local item = nil
function game:initialize()

end

function game:init()
  
end


function game:enter(previous) -- run every time the state is entered
  state.enter(self,previous)
  TEsound.playLooping("assets/sounds/Running in the 90's.mp3", 'song', 9999, 0.5, 1)
  bar = Bar()
  bar:addBulletTime(2)
  
end

function game:update(dt)
  if bar.items[1].name == 'PLAN' then
    timeScale = 0.2
  else
    timeScale = 1
  end
  
  TEsound.pitch('song', timeScale)
  
    
  if love.keyboard.isDown(' ') then
    item.timeLeft = item.timeLeft + dt*2
  end
  bar:update(dt)
  
end

function game:draw()
  state:draw()
  bar:draw()
  camera:attach()
  love.graphics.setColor(255,255,255,255)
  player:draw()
  camera:detach()
end

function game:keypressed(key)
  if key == ' ' then
      item = {}
      item.name = 'jump'
      item.timeLeft = 0
      bar:enqueue(item)
  end
end

function game:keyreleased(key)
  if key == ' ' then
      item = nil
  end
  
end

 
     
return game