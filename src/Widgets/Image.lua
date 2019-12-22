--[[
	This draws the Image at a relative/absolute position
]]

local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local util=require(LIB_PATH..'.Core.util')
local core=require(LIB_PATH..'.Core')
local DrawCommands=require(LIB_PATH..'.Core.drawCommands')

local function Image(img,x,y,w,h)
	if core.idle then return end
	local imgColor,r
	img,imgColor,r,x,y,w,h=util.getImageParams(img,x,y,w,h)

	local imgW,imgH=img:getDimensions()
	DrawCommands.registerCommand(function()
		love.graphics.setColor(1,1,1)
		if imgColor then love.graphics.setColor(unpack(imgColor)) end
		love.graphics.draw(img,x,y,r,w/imgW,h/imgH,imgW/2,imgH/2)
		-- love.graphics.draw(img,x,y,0,1,1,w/2,h/2)
	end)
end

return Image