--[[
	This module defines the very basic aspects of imgui!
]]

local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")


local uiState=require(LIB_PATH..'.Core.UIState')
local theme=require(LIB_PATH..'.Core.theme')
local util=require(LIB_PATH..'.Core.util')
local drawCommands=require(LIB_PATH..'.Core.drawCommands')
local Window=require(LIB_PATH..'.Widgets.Window')
local Layout=require(LIB_PATH..'.Widgets.Layout')


local imgui={
	['_genID']=0,
	['idle']=false,  --don't process any widget if idle!
	['autoIdle']=true,  --make imgui auto-idle for performance optimization
	['overSmart']=true, --don't hover any widget when another widget is already active!
	['pianoMode']=nil, --you'll know it when you see it
	['stack']=stack,
	['layout']=Layout,
	['theme']=theme,
	['uiState']=uiState,
	['drawCommands']=drawCommands
}

function imgui.genID()
	imgui['_genID']=imgui['_genID']+1
	return imgui['_genID']
end

--Performance Optimizations may still be buggy; so use this
function imgui.noOptimize()
	imgui.setCanvas(nil)
	imgui.setAutoIdle(nil)
end

--Set imgui over-smart
function imgui.setOverSmart(v)
	imgui.overSmart=v
end

--Refresh the canvas if there is any canvas
function imgui.refresh()
	if not drawCommands.directDraw and drawCommands.autoRefresh then
		drawCommands.needsRefresh=true
	end
end

function imgui.setAutoIdle(auto)
	imgui.idle=auto
	imgui.autoIdle=auto
end

--Should imgui draw to canvas or directly!
function imgui.setCanvas(canvas)
	drawCommands.directDraw=not canvas
end

--You'll know it when you see it!!
function imgui.setPianoMode(mode)
	imgui.pianoMode=mode
end

function imgui.draw()
	imgui.drawCommands.draw()
	if imgui.autoIdle then imgui.idle=true end
	if uiState.mouseUp==1 then uiState.mouseUp=nil end
	if uiState.mouseUp==0 then uiState.mouseUp=1 end
	if uiState.mouseUp then uiState.mouseUp=nil end
	-- if uiState.mouseUp then print(uiState.mouseUp) end
end

---At every frame we need to reset hotItem to nil
local function imgui_prepare()
	imgui['_genID']=0
	-- uiState.keyChar=nil
	uiState.hotItem=nil
	if imgui.pianoMode then
		print('doing')
		uiState.activeItem=nil
	end
	Layout.reset()
end

function imgui.update(dt)
	if imgui.idle then return end
	imgui.drawCommands.clear()
	imgui_prepare()
	theme.update(dt)	--> why? answered in theme.lua
	uiState.dt=dt
end

--should we support scankeys?? Who uses scan-keys anyway?
function imgui.keypressed(key) 
	uiState.keyDown=key
	if imgui.autoIdle then imgui.idle=false end
	imgui.refresh()
end

function imgui.keyreleased(key)
	uiState.keyDown=nil
	if imgui.autoIdle then imgui.idle=false end
	imgui.refresh()
end


function imgui.textinput(text)
	uiState.keyChar=text
	if imgui.autoIdle then imgui.idle=false end
	imgui.refresh()
end

function imgui.mousepressed(x,y,btn)
	if btn==1 then
		uiState.mouseDown=true
		if imgui.autoIdle then imgui.idle=false end
		imgui.refresh()
	end
end

function imgui.mousereleased(x,y,btn)
	if btn==1 then
		uiState.mouseUp=true
		uiState.mouseDown=false
		uiState.lastActiveItem=uiState.activeItem
		uiState.activeItem=nil
		if imgui.autoIdle then imgui.idle=false end
		imgui.refresh()
	end
end

function imgui.mousemoved(x,y)
	uiState.mouseX,uiState.mouseY=x,y
	if imgui.autoIdle then imgui.idle=false end
	imgui.refresh()
end

function imgui.wheelmoved(x,y)
	uiState.scrollDX=uiState.scrollDX+x
	uiState.scrollDY=uiState.scrollDY+y
	if imgui.autoIdle then imgui.idle=false end
	imgui.refresh()
end

--[INTERNAL]: An attempt to remove redundant logic
function imgui.updateWidget(id,cond)
	if cond then
		if imgui.overSmart then
			if uiState.activeItem and uiState.activeItem~=id then return end
		end
		uiState.hotItem=id
		if uiState.mouseDown and not uiState.activeItem then
			uiState.activeItem=id
		end
	else
		if not imgui.pianoMode then
			if uiState.activeItem==id then uiState.activeItem=0 end
		end
	end
end


function imgui.resize(w,h)
	imgui.resetCanvas(w,h)
	if imgui.autoIdle then imgui.idle=false end
	imgui.refresh()
end

--There's also imgui.resize!!
local setMode=love.window.setMode
love.window.setMode=function(w,h,...)
	imgui.resetCanvas(w,h)
	setMode(w,h,...)
end

--We need to make a new canvas on resizing
function imgui.resetCanvas(w,h)
	--We'll make a new canvas only for increase in window-size!
	if w>Window.stack[1].width or h>Window.stack[1].height then
		drawCommands.canvas:release()
		drawCommands.canvas=love.graphics.newCanvas(w,h)
	end
	Window.stack[1].width,Window.stack[1].height=w,h
end

return imgui