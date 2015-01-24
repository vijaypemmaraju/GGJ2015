GameState = require 'lib.hump.gamestate'
Timer = require 'lib.hump.timer'
require 'lib.lovedebug'
require 'globals'
game = require 'states.game'

--This function is called exactly once at the beginning of the game.
--@param(arg : unknown) A sequence strings which are command line arguments given to the game
function love.load(arg)
  GameState.registerEvents()
  GameState.switch(game)
  love.mouse.setCursor(defaultCursor)
  
end



function love.update(dt)
  TEsound.cleanup()
  Timer.update(dt*timeScale)
  
end

function love.keypressed(key)
  -- if key == 'f' then
  --   love.window.setFullscreen(not love.window.getFullscreen())
  -- end
  
    
end


function love.draw()
   
end