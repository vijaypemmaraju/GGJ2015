require 'lib.middleclass'
--[[
Copyright (c) 2010-2013 Matthias Richter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Except as contained in this notice, the name(s) of the above copyright holders
shall not be used in advertising or otherwise to promote the sale, use or
other dealings in this Software without prior written authorization.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
]]--


local cos, sin = math.cos, math.sin

local Camera = class('Camera')

gameWidth, gameHeight = gameResolution:unpack()

function Camera:initialize(x,y, zoom, rot)
	self.x,self.y  = x or gameWidth/2, y or gameHeight/2
	self.zoom = self.zoom or 1
  self.scale = 1
	self.rot  = self.rot or 0
end

function Camera:lookAt(x,y)
	self.x, self.y = x,y
	return self
end

function Camera:move(x,y)
	self.x, self.y = self.x + x, self.y + y
	return self
end

function Camera:pos()
	return self.x, self.y
end

function Camera:position()
	return Vector(self.x, self.y)
end



function Camera:rotate(phi)
	self.rot = self.rot + phi
	return self
end

function Camera:rotateTo(phi)
	self.rot = phi
	return self
end

function Camera:zoom(mul)
	self.scale = self.scale * mul
	return self
end

function Camera:zoomTo(zoom)
	self.scale = zoom
	return self
end

function Camera:attach()
	local cx,cy = gameWidth/(2*self.scale), gameHeight/(2*self.scale)
	love.graphics.push()
	love.graphics.scale(self.scale)
	love.graphics.translate(cx, cy)
	love.graphics.rotate(self.rot)
	love.graphics.translate(-self.x, -self.y)
end

function Camera:attachXOnly()
	local cx,cy = gameWidth/(2*self.scale), gameHeight/(2*self.scale)
	love.graphics.push()
	love.graphics.scale(self.scale)
	love.graphics.translate(cx, 0)
	love.graphics.rotate(self.rot)
	love.graphics.translate(-self.x, 0)
end

function Camera:detach()
	love.graphics.pop()
end

function Camera:draw(func)
	self:attach()
	func()
	self:detach()
end

function Camera:cameraCoords(x,y)
	-- x,y = ((x,y) - (self.x, self.y)):rotated(self.rot) * self.scale + center
  local ratioX, ratioY = gameWidth/love.window.getWidth(),gameHeight/love.window.getHeight()
	local w,h = gameWidth, gameHeight
	local c,s = cos(self.rot), sin(self.rot)
	x,y = x - self.x, y - self.y
	x,y = c*x - s*y, s*x + c*y
	return x*self.scale*ratioX + w/2, y*self.scale*ratioY + h/2
end

function Camera:worldCoords(x,y)  
  local ratioX, ratioY = gameWidth/love.window.getWidth(),gameHeight/love.window.getHeight()
  if love.window.getWidth()/love.window.getHeight() ~= 4/3 then
    ratioX, ratioY = gameHeight/love.window.getHeight(),gameHeight/love.window.getHeight()
  end
  local offsetX = (love.window.getWidth()-gameResolution.x*love.window.getHeight()/gameResolution.y)/2 
	-- x,y = (((x,y) - center) / self.scale):rotated(-self.rot) + (self.x,self.y)
	local w,h = gameWidth, gameHeight
	local c,s = cos(-self.rot), sin(-self.rot)
	x,y = (x*ratioX - w/2) / self.scale, (y*ratioY - h/2) / self.scale
	x,y = c*x - s*y, s*x + c*y
	return -offsetX + x+self.x, y+self.y
end

function Camera:mousepos()
	return self:worldCoords(love.mouse.getPosition())
end

-- the module
--return setmetatable({new = new},
--	{__call = function(_, ...) return new(...) end})
return Camera