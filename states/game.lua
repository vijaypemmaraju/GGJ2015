require 'states.state'
require 'game.player'
require 'game.bar'
require 'game.map'
cam = require 'lib.hump.camera'

camera = cam()
player = Player(Vector(50,50))


local item = nil
function game:initialize()

end

function game:init()
end


function game:enter(previous) -- run every time the state is entered
  state.enter(self,previous)
  TEsound.playLooping("assets/sounds/Running in the 90's.mp3", 'song', 9999, 0.5, 1)
  bar = Bar()
  bar:addBulletTime(1)
  
end

function game:update(dt)
  map:update(dt)
  if bar.items[1].name == 'PLAN' then
    timeScale = 0.2
  else
    timeScale = 1
  end
  player:update(dt*timeScale)
  TEsound.pitch('song', timeScale)
  
    
  if love.keyboard.isDown(' ') and bar:isBulletTime()  then
    item.timeLeft = item.timeLeft + dt*2
  end
  bar:update(dt*timeScale)
  
  if #bar.items == 0 then
    bar:addBulletTime(1)
  end
  
  camera.x = camera.x + dt*timeScale*100
  player:update(dt)
end

function game:draw()
  state:draw()
  bar:draw()
  camera:attach()
  map:draw()
  love.graphics.setColor(255,255,255,255)
  player:draw()
  camera:detach()
end

function game:keypressed(key)
  if key == ' ' and bar:isBulletTime() then
    item = {}
    item.name = 'jump'
    item.actionTime = 0.5
    item.timeLeft = item.actionTime
    
    bar:enqueue(item)
  elseif key == 'right' then
    player:moveRight()
  elseif key == 'left' then
    player:moveLeft()
  elseif key == 'up' then
    player:moveUp()
  elseif key == 'down' then
    player:moveDown()
  end
  
  if key == 's' then
    player:slide()
  end
  
  if key == 'p' then
    player.position = Vector(player.position.x,50)
    player.acceleration = Vector(0, gravity)
    player.velocity = Vector(player.velocity.x, 0)
  end
  
end

function game:keyreleased(key)
  if key == ' ' then
      item = nil
  end
  
end

 
     
return game