--[[
	Stepper is basically a label+two buttons that may-be top-and-down
	or left-and-right depending on direction!
]]


--[[
	WORK IN PROGRESS: Wanna help me out :>
]]


local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local uiState=require(LIB_PATH..'.Core.UIState')
local util=require(LIB_PATH..'.Core.util')
local param=require(LIB_PATH..'.Core.param')
local theme=require(LIB_PATH..'.Core.theme')
local core=require(LIB_PATH..'.Core')
local DrawCommands=require(LIB_PATH..'.Core.drawCommands')

local function Stepper(stepper,x,y,w,h)
	if core.idle then return end
	local id=core.genID()
	x,y,w,h=util.getStepperParams(stepper,x,y,w,h)
	local lx,ly,lw,lh=param.getStepperLeftButton(stepper,x,y,w,h)
	local rx,ry,rw,rh=param.getStepperRightButton(stepper,x,y,w,h)
	core.updateWidget(
		id,
		util.mouseOver(lx,ly,lw,lh) or util.mouseOver(rx,ry,rw,rh)
	)
	local updated
	if core.isMouseReleased() then
		if util.mouseOver(lx,ly,lw,lh) then
			stepper.active=util.warp(stepper.active-1,1,#stepper.list)
			updated=true
		elseif util.mouseOver(rx,ry,rw,rh) then
			stepper.active=util.warp(stepper.active+1,1,#stepper.list)
			updated=true
		end
		
	end
	if uiState.hotItem==id then
		if uiState.activeItem==id then
			DrawCommands.registerCommand(function()
				theme.drawStepperPressed(stepper,util.mouseOver(lx,ly,lw,lh),x,y,w,h)
			end)
		else
			DrawCommands.registerCommand(function()
				theme.drawStepperHover(stepper,util.mouseOver(lx,ly,lw,lh),x,y,w,h)
			end)
		end
	else
		DrawCommands.registerCommand(function()
			theme.drawStepperNormal(stepper,x,y,w,h)
		end)
	end

	return updated
end

return Stepper