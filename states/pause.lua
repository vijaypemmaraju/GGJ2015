require 'states.state'

function pause:initialize()
  state:initialize(self)
  --print("INITIALIZED!")
  --print(self.transitionInTime)
end

function pause:init()
  state.init(self)

end


function pause:enter(previous) -- run every time the state is entered
  state.enter(self,previous)
  TEsound.pause("song")
  
end

function pause:update(dt)
  state.update(self, dt)

end

function pause:draw()
  state:draw()
  love.graphics.setColor(0,0,0,150)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setColor(255,255,255,255)
  love.graphics.setFont(pauseFont)
  love.graphics.print("PAUSED",love.graphics.getWidth()/2 - 50, love.graphics.getHeight()/2)
  
end

function pause:keypressed(key)
  if key == 'escape' then
    TEsound.resume("song")
    GameState.pop()
  end
  
end

function pause:keyreleased(key)
  if key == ' ' then
      item = nil
  end
  
end

 
     
return pause()