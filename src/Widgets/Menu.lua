--[[
	Menus generally don't need a menubar for them to rendered
	making them context-menus
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

--Text of the menu and width of all the previous menus
local width --why waste memory in stacks when a single variable can do the job!
local menuText --same case here

local function BeginMenu(text)
	if core.idle then return end
	menuText=text
	width=Window.getMenuWidth()
	local w,h=theme.getFontSize('menu',text..'a')--trick for padding!
	Window.addMenu(w) 
	local x,y=Window.getTopLeft() x=x+width
	if util.mouseOver(x,y,w,h) then
		DrawCommands.registerCommand(-1,function()
			theme.drawMenuHover(text,x,y,w,h)
		end)
	else
		DrawCommands.registerCommand(-1,function()
			theme.drawMenuNormal(text,x,y)
		end)
	end
	return true
end

local function EndMenu()
	local text=menuText --IMPORTANT!!! This is how Lua works dude!
	
end

return {BeginMenu,EndMenu}

--[[
	WORK IN PROGRESS: Wanna help me out :>
]]