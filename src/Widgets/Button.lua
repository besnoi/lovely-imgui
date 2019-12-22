--[[
	This draws the button at a relative/absolute position
]]

local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local uiState=require(LIB_PATH..'.Core.UIState')
local util=require(LIB_PATH..'.Core.util')
local theme=require(LIB_PATH..'.Core.theme')
local core=require(LIB_PATH..'.Core')
local DrawCommands=require(LIB_PATH..'.Core.drawCommands')

local function Button(text,x,y,w,h)
	if core.idle then return end
	local id=core.genID()
	text,x,y,w,h=util.getButtonParams(text,x,y,w,h)
	core.updateWidget(id,util.mouseOver(x,y,w,h))
	if uiState.hotItem==id then
		if uiState.activeItem==id then
			DrawCommands.registerCommand(function()
				theme.drawButtonPressed(text,x,y,w,h)
			end)
		else
			DrawCommands.registerCommand(function()
				theme.drawButtonHover(text,x,y,w,h)
			end)
		end
	else
		DrawCommands.registerCommand(function()
			theme.drawButtonNormal(text,x,y,w,h)
		end)
	end

	return (uiState.hotItem==id and uiState.activeItem==id) or (
		uiState.lastActiveItem==id and uiState.mouseUp
	)
end

return Button