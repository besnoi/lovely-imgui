--[[
	A Slider is slightly more complicated variant of slider!
	It has increments and a "thumb" and by default it doesn't have
	a progress bar but themes can go nasty and implement it!
	Unlike Scalers, Sliders do not have to worry about orientation!
]]

local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local uiState=require(LIB_PATH..'.Core.UIState')
local util=require(LIB_PATH..'.Core.util')
local theme=require(LIB_PATH..'.Core.theme')
local core=require(LIB_PATH..'.Core')
local DrawCommands=require(LIB_PATH..'.Core.drawCommands')

local function Slider(slider,x,y,w,h)
	if core.idle then return end
	local fraction,sx,sy,sw,sh  --thumb dimenions and position
	local id=core.genID()
	fraction,x,y,w,h,sx,sy,sw,sh=util.getSliderParams(slider,x,y,w,h)
	
	core.pianoMode=not core.pianoMode
	core.updateWidget(id,util.mouseOver(sx,sy,sw,sh)) --remove 's' if you want to disable "thumb only"!
	core.pianoMode=not core.pianoMode

	if uiState.activeItem==id then
		if slider.vertical then
			fraction = math.min(1, math.max(0, (uiState.mouseY - y) / h))
		else
			fraction = math.min(1, math.max(0, (uiState.mouseX - x) / w))
		end
		DrawCommands.registerCommand(function()
			theme.drawSliderPressed(fraction,slider.vertical,x,y,w,h,slider.style)
		end)
		local v = fraction * (slider.max - slider.min) + slider.min
		if v ~= slider.value then
			slider.value = v
			return true
		end
	elseif uiState.hotItem==id then
		DrawCommands.registerCommand(function()
			theme.drawSliderHover(fraction,slider.vertical,x,y,w,h,slider.style)
		end)
	else
		DrawCommands.registerCommand(function()
			theme.drawSliderNormal(fraction,slider.vertical,x,y,w,h,slider.style)
		end)
	end
end

return Slider