require 'states.state'
require 'game.player'
require 'game.bar'
require 'game.map'
cam = require 'lib.hump.camera'

camera = cam()
player = Player(Vector(0,280))
runTimer = 0


defaultBulletTime = 0.125/2
local item = nil
function game:initialize()
  state.initialize(self)

end

function game:init()
  state.init(self)
end


function game:enter(previous) -- run every time the state is entered
  state.enter(self,previous)
  TEsound.playLooping("assets/sounds/Running in the 90's.mp3", 'song', 9999, 0.5, 1)
  bar = Bar()
  bar:addBulletTime(defaultBulletTime)
  player.position.x = player.texture:getWidth()
end

function game:update(dt)
  runTimer = runTimer + dt
  state.update(self, dt)
  map:update(dt)
  if bar.items[1].name == 'PLAN' then
    timeScale = 0.025
  else
    timeScale = 1
  end
  player:update(dt*timeScale)
  TEsound.pitch('song', math.max(timeScale, 0.5))
  
    
  if (love.keyboard.isDown(' ') or love.keyboard.isDown('s')) and item ~= nil  then
    item.timeLeft = item.timeLeft + dt*0.5
  end
  bar:update(dt*timeScale)
  
  if #bar.items == 0 then
    bar:addBulletTime(defaultBulletTime)
  end
  
  camera.x = player.position.x + 150--camera.x + dt*timeScale*bar.barScale
  camera.y = player.position.y
end

function game:draw()
  love.graphics.setBackgroundColor(155,147, 124, 255)
  state:draw()
  camera:attachXOnly()
  bar:draw()
  camera:detach()
  camera:attach()
  
  map:draw()
  map:drawWorldCollision(collision)
  love.graphics.setColor(255,255,255,255)
  player:draw()
  camera:detach()
  love.graphics.setFont(timerFont)
  love.graphics.print(tostring(math.round(runTimer, 2)), 50, 50)
  
  
  if bar:isBulletTime() then
    love.graphics.setColor(50, 50, 50, 150)
    love.graphics.rectangle('fill', 0, 0, love.window.getWidth(), love.window.getHeight())
  end
   
end

function game:keypressed(key)
  
  if key == 'right' then
    player:moveRight()
  elseif key == 'left' then
    player:moveLeft()
  elseif key == 'up' then
    player:moveUp()
  elseif key == 'down' then
    player:moveDown()
  end
  
  if key == 'escape' then
    GameState.push(pause)
  end

  --if bar:isBulletTime() then
    if key == 's' then
        item = {}
        item.name = 'slide'
        item.actionTime = player.maxSlideTimer
        item.timeLeft = 0
        item.hasPerformed = false
        item.action = player.slide
        bar:enqueue(item)
  
    elseif key == ' ' then
        item = {}
        item.name = 'jump'
        item.actionTime = player.jumpTimer
        item.timeLeft = 0
        item.hasPerformed = false
        item.action = player.jump
        bar:enqueue(item)
    elseif key == 'd' then
        item = {}
        item.name = 'delay'
        item.timeLeft = 0
        item.hasPerformed = false
        item.action = player.delay
        bar:enqueue(item)
    end
--  end
  
  
  if key == 'p' then
    player.position = Vector(0,270)
    player.acceleration = Vector(0, gravity)
    player.velocity = Vector(player.velocity.x, 0)
    bar = Bar()
    bar:addBulletTime(defaultBulletTime)
    
  end

  
end

function game:keyreleased(key)
  if key == ' ' then
      item = nil
  end
  
end

 
     
return game()
