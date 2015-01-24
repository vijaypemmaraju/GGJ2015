require 'game.gameobject'

Bar = GameObject:subclass("Bar") 

function Bar:initialize() 
  self.items = {}
    
end


function Bar:update()
end


function Bar:enqueue(item) 
  items.push(item)
end



