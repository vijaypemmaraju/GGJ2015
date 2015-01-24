--requires
require 'lib.require'
require 'util'
Vector = require 'lib.hump.vector'
class = require 'lib.middleclass'
Signals = require 'lib.hump.signal'
require 'color'
HC = require 'lib.HardonCollider'
shapes = require 'lib.HardonCollider.shapes'
require 'lib.richtext'
require 'lib.TESound'
sti = require 'lib.sti'

--collider
function on_collision(dt, a, b, dx, dy)

end

--states
require 'states.state'
menu = state:subclass('menu')
pause = state:subclass('pause')
game = state:subclass('game')

Collider = HC(100, on_collision)

time = 0
timeScale = 1

gravity = 3500 -- Acceleration of Gravity

gameResolution = Vector(800, 600)

function getVolume(amount) 
  return math.exp(amount)/10
end


function saveSettings()
  w,h,flags = love.window.getMode()
  table.save({w,h,flags}, 'settings.ini')
end

function loadSettings()
  local settings = table.load('settings.ini')
  if settings then
    return settings
  else
    return nil
  end
  
end


function glowShape(r, g, b, a, type, ...)
  love.graphics.setColor(r, g, b, 15/255*a)
  
  for i = 7, 2, -1 do
    if i == 2 then
      i = 1
      love.graphics.setColor(r, g, b, a)   
    end
    
    love.graphics.setLineWidth(i)
    
    if type == "line" then
      love.graphics[type](...)
    else
      love.graphics[type]("fill", ...)
    end
  end
end


function printTable(table)
  for i, value in pairs(table) do
    if type(value) == 'table' then
      printTable(value)
      print()
    else
      print(i .. ": " .. tostring(value))
    end
  end
end



---FONTS---
pauseFont = love.graphics.newFont(24)
