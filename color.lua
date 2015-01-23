class = require 'lib.middleclass'

Color = class('Color')

function Color:initialize(r,g,b,a) 
  self.r = r
  self.g = g
  self.b = b
  self.a = a
end

function Color:set(r,g,b,a) 
  self.r,self.g,self.b,self.a = r,g,b,a 
end
   
    
function Color:set(color) 
  self.r,self.g,self.b,self.a = color:unpack() 
end
    
function Color:unpack() 
  return self.r,self.g,self.b,self.a 
end
