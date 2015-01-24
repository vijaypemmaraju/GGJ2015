require 'game.gameobject'

Bar = class("Bar") 

function Bar:initialize() 
  self.items = {}
  
end


function Bar:update(dt)
  if #self.items > 0 then
    self.items[1].timeLeft = self.items[1].timeLeft - dt
    if self.items[1].timeLeft <= 0 then
      table.remove(self.items, 0)
    end
  end
  
end

function Bar:addBulletTime(amount) 
  item = {}
  item.name = "PLAN"
  item.timeLeft = amount
  table.insert(self.items, item)
end

function Bar:enqueue(item) 

  table.insert(self.items, item)
end

function Bar:draw()
  x = 0
  for index, item in pairs(self.items) do
     width = item.timeLeft * 100
     love.graphics.setColor(155,155,155,155)
     love.graphics.rectangle('fill', x, 50, width, 50)
     love.graphics.setColor(25,25,25,155)
     love.graphics.printf(item.name, x, 50, width, 'center')
     x = x + width
  end
  
end



