--[[
	Progress Bar are very essential for loading screens and stuff like that!
	Because of the way Lovely-imGUI has been designed you can have variety
	of progress-bars with themes! If you want different progress bars
	without messing with themes then you should probably edit this file!
	Orientation of progress bars is again handled by themes which can make use
	of the style parameter that's passed in the last argument!
]]

local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local uiState=require(LIB_PATH..'.Core.UIState')
local theme=require(LIB_PATH..'.Core.theme')
local util=require(LIB_PATH..'.Core.util')
local core=require(LIB_PATH..'.Core')
local DrawCommands=require(LIB_PATH..'.Core.drawCommands')

local function ProgressBar(progressBar,x,y,w,h)
	if core.idle then return end
	x,y,w,h=util.getProgressBarParams(progressBar,x,y,w,h)
	progressBar._timer=progressBar._timer or 0
	progressBar._timer=progressBar._timer+uiState.dt
	--By default the progress is linear and lasts for 5 seconds!
	progressBar.update=progressBar.update or function(dt) return dt/5 end
	progressBar.value=progressBar.value or 0
	if progressBar.value<1 then
		local updateValue=progressBar.update(uiState.dt,progressBar._timer)
		progressBar.value=math.min(1,progressBar.value+updateValue)
	else
		progressBar._timer=0
	end
	DrawCommands.registerCommand(function()
		theme.drawProgressBar(progressBar.text,progressBar.value,x,y,w,h,progressBar.style)
	end)
end

return ProgressBar