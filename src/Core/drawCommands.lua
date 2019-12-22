--[[
	We don't need to draw at every frame! That'd be stupid
	So to make the library "bloat-free", imgui draws to a
	canvas which only updates when an input happens!
	Now using a canvas which may result in loss of quality
	so to turn off this feature simply say `imgui.setCanvas(false)`
	anywhere before `imgui.draw()`!
	To explicity refresh canvas say - `imgui.refresh()`
]]

local CORE_PATH = (...):match("^(.+)%.[^%.]+")

--Command Format: 
--	function() theme.drawButtonNormal(t,x,y,w,h) end
local commands={}

local drawCommands={
	reverseTop=0, --needed for handling Z-index
	canvas=love.graphics.newCanvas(love.graphics.getDimensions()),
	directDraw=false,
	needsRefresh=true, --refresh canvas?
	autoRefresh=true,  --automatically refresh canvas?
	commands=commands
}

local setCanvas=love.graphics.setCanvas

drawCommands.draw=function()
	if drawCommands.directDraw or
	  (drawCommands.autoRefresh and drawCommands.needsRefresh) then
		-- print('drawing')
		if drawCommands.needsRefresh and not drawCommands.directDraw then
			-- print('setting canvas')
			setCanvas(drawCommands.canvas)
			love.graphics.clear()
		end
		--Z-index is automatically handled before drawing!
		drawCommands.handleDepth()
		for i=1,#commands do
			commands[i]()
		end
		if drawCommands.needsRefresh and not drawCommands.directDraw then
			drawCommands.needsRefresh=false
			drawCommands.clear()  --> TODO: Check if this is buggy
			setCanvas()
		end
	end
	if not drawCommands.directDraw then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(drawCommands.canvas)
	end
	drawCommands.reverseTop=0
end

drawCommands.registerCommand=function (zindex,func)
	if not func then func,zindex=zindex,#commands+1 end

	if zindex==-1 then
		--We want this widget to have high depth!
		drawCommands.reverseTop=drawCommands.reverseTop-1
		commands[drawCommands.reverseTop]=func
	else
		table.insert(commands,zindex,func)
	end
	drawCommands.needsRefresh=true
end

--Move all the negative values to positive values!
drawCommands.handleDepth=function()
	local i=-1
	while true do
		if not commands[i] then return end
		table.insert(commands,commands[i])
		commands[i]=nil
		i=i-1
	end
end

drawCommands.clear=function()
	if #commands>100 then
		commands={}
	else
		for i=1,#commands do table.remove(commands,i) end
	end
end

return drawCommands