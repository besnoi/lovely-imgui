--[[
	This draws a checkbox (with/without label) at a relative/absolute position
]]

local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local uiState=require(LIB_PATH..'.Core.UIState')
local util=require(LIB_PATH..'.Core.util')
local theme=require(LIB_PATH..'.Core.theme')
local core=require(LIB_PATH..'.Core')
local DrawCommands=require(LIB_PATH..'.Core.drawCommands')

local function CheckBox(isChecked,text,x,y,w,h)
	if core.idle then return end
	local id=core.genID()
	isChecked,text,x,y,w,h=util.getCheckBoxParams(isChecked,text,x,y,w,h)
	--For the check-box and the label!!
	core.updateWidget(
		id,
		util.mouseOver(x,y,w,h) or 
		(text and
			util.mouseOver(
				x+w+15,y,theme.getFontSize('checkbox',text),h
			)
		)
	)
	if uiState.hotItem==id then
		if uiState.activeItem==id then
			DrawCommands.registerCommand(function()
				theme.drawCheckBoxPressed(isChecked[1],text,x,y,w,h)
			end)
		else
			DrawCommands.registerCommand(function()
				theme.drawCheckBoxHover(isChecked[1],text,x,y,w,h)
			end)
		end
	else
		DrawCommands.registerCommand(function()
			theme.drawCheckBoxNormal(isChecked[1],text,x,y,w,h)
		end)
	end
	if uiState.lastActiveItem==id then
		--If the last thing that was clicked was this check-box
		isChecked[1]=not isChecked[1]
		uiState.lastActiveItem=nil
		return true
	end
end

return CheckBox