class = require 'lib.middleclass'

state = class('state')

function state:initialize()
  self.transitionDelta = 0
  self.transitionState = "in"
  
  self.transitionInTime = 1
  self.transitionOutTime = 0.5
end


function state:init() -- run only once
  
end


function state:enter(previous) -- run every time the state is entered
  self.transitionDelta = 0
  self.transitionState = "in"
end


function state:update(dt)
  if self.transitionState == "in" then
    self.transitionDelta = self.transitionDelta + dt/self.transitionInTime
    if self.transitionDelta >= 1 then
      self.transitionDelta = 1
      self.transitionState = "on"
    end
  elseif self.transitionState == "out" then
    self.transitionDelta = self.transitionDelta - dt/self.transitionOutTime
    if self.transitionDelta <= 0 then
      self.transitionDelta = 0
      self.transitionState = "off"
    end
  end
end


function state:draw()
  
end

function state:keypressed(key, isrepeat)
   
end



function state:mousepressed(x,y, btn)
 
end
  