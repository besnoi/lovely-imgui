--[[
	This draws a radio-button (with/without label) at a relative/absolute position
]]

local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local uiState=require(LIB_PATH..'.Core.UIState')
local util=require(LIB_PATH..'.Core.util')
local theme=require(LIB_PATH..'.Core.theme')
local core=require(LIB_PATH..'.Core')
local DrawCommands=require(LIB_PATH..'.Core.drawCommands')

local function RadioButton(rbtn,text,x,y,w,h)
	if core.idle then return end
	local id=core.genID()
	--TODO: Remove rbtn from getRadioParams for possible performance optimization!
	rbtn,text,x,y,w,h=util.getRadioButtonParams(rbtn,text,x,y,w,h)
	--For the check-box and the label!!
	core.updateWidget(
		id,
		util.mouseOver(x,y,w,h) or 
		(text and
			util.mouseOver(
				x+w+15,y,theme.getFontSize('radiobutton',text),h
			)
		)
	)
	if uiState.hotItem==id then
		if uiState.activeItem==id then
			DrawCommands.registerCommand(function()
				theme.drawRadioButtonPressed(rbtn.active,text,x,y,w,h)
			end)
		else
			DrawCommands.registerCommand(function()
				theme.drawRadioButtonHover(rbtn.active,text,x,y,w,h)
			end)
		end
	else
		DrawCommands.registerCommand(function()
			theme.drawRadioButtonNormal(rbtn.active,text,x,y,w,h)
		end)
	end
	--TODO: Make other radio buttons return 0 and this return 1
	if uiState.lastActiveItem==id then
		--If the last thing that was clicked was this radio-button
		rbtn.active=true
		if rbtn.group then
			for i=1,#rbtn.group do
				if rbtn.group[i]~=rbtn then
					rbtn.group[i].active=nil
				end
			end
		end
		uiState.lastActiveItem=nil
		return true
	end
end

return RadioButton