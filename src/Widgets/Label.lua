--[[
	This draws the label at a relative/absolute position
]]

local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local theme=require(LIB_PATH..'.Core.theme')
local util=require(LIB_PATH..'.Core.util')
local core=require(LIB_PATH..'.Core')
local DrawCommands=require(LIB_PATH..'.Core.drawCommands')

local function Label(text,x,y)
	if core.idle then return end
	x,y=util.getLabelParams(text,x,y)
	DrawCommands.registerCommand(function()
		if type(text)=='string' then
			theme.drawLabel(text,x,y)
		else
			love.graphics.setColor(1,1,1)
			if text.color then love.graphics.setColor(text.color) end
			if text.font then love.graphics.setFont(text.font) end
			love.graphics.print(text.text,x,y)
		end
	end)
end

return Label