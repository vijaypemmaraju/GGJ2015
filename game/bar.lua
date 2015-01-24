require 'game.gameobject'

Bar = class("Bar") 

function Bar:initialize() 
  self.items = {}
  self.barScale = player.velocity.x
end


function Bar:update(dt)
  if #self.items > 0 then
    item = self.items[1]
    if not item.hasPerformed and item.action then
      item.action(player)
      item.hasPerformed = true
    end
    item.actionTime = item.actionTime - dt
    if item.actionTime <= 0 then
      table.remove(self.items, 1)
    end
  end
  
end

function Bar:addBulletTime(amount) 
  item = {}
  item.name = "PLAN"
  item.actionTime = amount

  table.insert(self.items, item)
end

function Bar:enqueue(item) 

  table.insert(self.items, item)
end


function Bar:isBulletTime()
  return #self.items > 0 and self.items[1].name == 'PLAN'
end


function Bar:draw()
  x = player.position.x
  for index, item in pairs(self.items) do
     actionWidth = item.actionTime * self.barScale
     if actionWidth > 0 then


       -- draw item rectangle
       if item.name == "PLAN" then
          love.graphics.setColor(200,55,155,155)
       else
          love.graphics.setColor(255,155,155,155)
       end
     
       love.graphics.rectangle('fill', x, 0, actionWidth, 50)
       
       -- draw left and right edges 
       love.graphics.setColor(255,255,255,155)
       love.graphics.line(x, 0, x , love.graphics.getHeight())
       love.graphics.line(x+actionWidth, 0, x+actionWidth  , love.graphics.getHeight())
      
       --  draw text 
       love.graphics.setColor(25,25,25,155)
       love.graphics.printf(item.name, x, 0, actionWidth, 'center')
       -- if item.name == "PLAN" then
       --   love.graphics.setColor(25,25,25,155)
       --   love.graphics.printf(item.name, x, 0, width, 'center')
       -- elseif width > 0 then
       --   love.graphics.setColor(25,25,25,155)
       --   love.graphics.printf("DELAY", x, 0, width, 'center')
       -- end
       
       
         x = x + actionWidth
       
       -- if item.actionTime > 0 then
       --   width = actionWidth
       --   love.graphics.setColor(255,55,55,155)
       --   love.graphics.rectangle('fill', x, 0, width, love.graphics.getHeight())
         
       --   love.graphics.setColor(255,255,255,155)
       --   love.graphics.line(x, 0, x , 50)
       --   love.graphics.line(x+width, 0, x+width  , love.graphics.getHeight())
         
       --   love.graphics.setColor(25,25,25,155)
       --   love.graphics.printf(item.name, x, 0, width, 'center')
       --   x = x + width
       -- end
       
       
      

     end
  end
  
end



