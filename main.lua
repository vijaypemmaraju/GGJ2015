GameState = require 'lib.hump.gamestate'
Timer = require 'lib.hump.timer'
require 'lib.lovedebug'
require 'globals'
game = require 'states.game'
pause = require 'states.pause'

--This function is called exactly once at the beginning of the game.
--@param(arg : unknown) A sequence strings which are command line arguments given to the game
function love.load(arg)
  GameState.registerEvents()
  GameState.switch(game)
  love.mouse.setCursor(defaultCursor)

  -- Load a map exported to Lua from Tiled
  map = sti.new("assets/levels/level3")
  world = love.physics.newWorld()
  collision = map:initWorldCollision(world)
 
     collisionTiles = {}
    for _, obj in ipairs(collision) do
     -- if type(obj.shape) == "table" then
        local a,b,c,d,e,f,g,h = collision.body:getWorldPoints(obj.shape:getPoints())
        table.insert(collisionTiles, shapes.newPolygonShape(a,b,c,d,e,f,g,h))
     -- end
      
    end
    
    deathTiles = {}
    for _, obj in pairs(map.layers.Death.objects) do
      local x,y,w,h = obj.x, obj.y, 64,64
      print(x,y,w,h)
      table.insert(deathTiles, shapes.newPolygonShape(x,y, x+w,y, x+w,y+h,  x,y+h))
  end
 

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