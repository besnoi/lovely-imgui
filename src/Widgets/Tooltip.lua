--[[
	This draws the Tooltip at a relative/absolute position
	Tooltip speaks for the next widget that is to be rendered!
	Tooltip will normally be displayed instantly! For delays
	one must rely on the LAF!
]]

local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local theme=require(LIB_PATH..'.Core.theme')
local uiState=require(LIB_PATH..'.Core.UIState')
local util=require(LIB_PATH..'.Core.util')
local core=require(LIB_PATH..'.Core')
local DrawCommands=require(LIB_PATH..'.Core.drawCommands')

local function Tooltip(text,x,y)
	if core.idle then return end
	local id=core.genID()
	x,y=util.getTooltipParams(text,x,y)
	DrawCommands.registerCommand(-1,function()
		if uiState.hotItem~=id+1 then return end

		if type(text)=='string' then
			theme.drawTooltip(text,x,y)
		else
			love.graphics.setColor(1,1,1)
			if text.color then love.graphics.setColor(text.color) end
			if text.font then love.graphics.setFont(text.font) end
			love.graphics.print(text.text,x,y)
		end
	end)
end

return Tooltip