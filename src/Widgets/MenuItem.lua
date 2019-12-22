--[[
	MenuItem is really just anything that goes into a menu!
	There's checked menu-item, radio-menu item and normal
	label-menu-item!
]]

local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local uiState=require(LIB_PATH..'.Core.UIState')
local util=require(LIB_PATH..'.Core.util')
local theme=require(LIB_PATH..'.Core.theme')
local core=require(LIB_PATH..'.Core')
local DrawCommands=require(LIB_PATH..'.Core.drawCommands')
local Window=require(LIB_PATH..'.Widgets.Window')

local function BeginMenuBar()
	Window.addMenuBar()
	return true
end

local function EndMenuBar()
	local x,y=Window.getTopLeft()
	local w,h=theme.getFontSize('menu','')
	w=Window.getDimensions()
	DrawCommands.registerCommand(function()
		theme.drawMenuBar(x,y,w,h)
	end)
end

return {BeginMenuBar,EndMenuBar}

--[[
	WORK IN PROGRESS: Wanna help me out :>
]]