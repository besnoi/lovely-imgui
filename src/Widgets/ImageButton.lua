--[[
	This draws the Image at a relative/absolute position
]]

local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local uiState=require(LIB_PATH..'.Core.UIState')
local util=require(LIB_PATH..'.Core.util')
local core=require(LIB_PATH..'.Core')
local DrawCommands=require(LIB_PATH..'.Core.drawCommands')

local function ImageButton(img,x,y,w,h)
	if core.idle then return end

	local id=core.genID()
	x,y,w,h=util.getImageButtonParams(img,x,y,w,h)

	local imgW,imgH=img.image:getDimensions()
	local cond=util.mouseOver(x-w/2,y-h/2,w,h)
	if cond and img.precise then
		--If mouse is in the bounding-box and precise-mask is on then
		local imageData=img.data
	end
	core.updateWidget(id,cond)
	
	if uiState.hotItem==id then
		if uiState.activeItem==id then
			DrawCommands.registerCommand(function()
				love.graphics.setColor(1,1,1)
				if img.active then love.graphics.setColor(unpack(img.active)) end
				love.graphics.draw(img.image,x,y,img.rotation,w/imgW,h/imgH,imgW/2,imgH/2)
			end)
		else
			DrawCommands.registerCommand(function()
				love.graphics.setColor(1,1,1)
				if img.hover then love.graphics.setColor(unpack(img.hover)) end
				love.graphics.draw(img.image,x,y,img.rotation,w/imgW,h/imgH,imgW/2,imgH/2)
			end)
		end
	else
		DrawCommands.registerCommand(function()
			love.graphics.setColor(1,1,1)
			if img.default then love.graphics.setColor(unpack(img.default)) end
			love.graphics.draw(img.image,x,y,img.rotation,w/imgW,h/imgH,imgW/2,imgH/2)
		end)
	end

	-- love.graphics.rectangle('line',x-w/2,y-h/2,w,h)
	

	DrawCommands.registerCommand(function()
		love.graphics.setColor(1,1,1)

		
	end)

	return (uiState.hotItem==id and uiState.activeItem==id) or (
		uiState.lastActiveItem==id and uiState.mouseUp
	)
end

return ImageButton