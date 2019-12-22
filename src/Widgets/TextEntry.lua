--[[
	A TextEntry is similar to Java Swing TextField - it's single-line
	and when you hit enter it's done!
]]


--[[
	WORK IN PROGRESS: Wanna help me out :>
	TODO: Auto-scrolling for text (_offset here means just that!)
	TODO: Add selection support!
]]


local LIB_PATH = (...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local uiState=require(LIB_PATH..'.Core.UIState')
local util=require(LIB_PATH..'.Core.util')
local theme=require(LIB_PATH..'.Core.theme')
local core=require(LIB_PATH..'.Core')
local DrawCommands=require(LIB_PATH..'.Core.drawCommands')

local function split(str, pos) return str:sub(1, pos), str:sub(1+pos) end

local function TextEntry(textEntry,x,y,w,h)
	if core.idle then return end
	local id=core.genID()
	x,y,w,h=util.getTextEntryParams(textEntry,x,y,w,h)
	core.updateWidget(id,util.mouseOver(x,y,w,h))
	if uiState.lastActiveItem==id then
		if uiState.keyChar then
			if not textEntry.limit or textEntry.text:len()<textEntry.limit then
				local left,right=split(textEntry.text,textEntry._cursor)
				textEntry.text=left..uiState.keyChar..right
				textEntry._cursor=textEntry._cursor+1
			end
			uiState.keyChar=nil
		else
			if uiState.keyDown=='left' then
				textEntry._cursor=math.max(0,textEntry._cursor-1)
				uiState.keyDown=nil
			elseif uiState.keyDown=='right' then
				textEntry._cursor=math.min(textEntry.text:len(),textEntry._cursor+1)
				uiState.keyDown=nil
			elseif uiState.keyDown=='delete' then
				local left,right=split(textEntry.text,textEntry._cursor)
				textEntry.text=left..(right:sub(2))
				uiState.keyDown=nil
			elseif uiState.keyDown=='backspace' then
				local left,right=split(textEntry.text,textEntry._cursor)
				textEntry.text=left:sub(1,left:len()-1)..right
				uiState.keyDown=nil
			end
		end
		DrawCommands.registerCommand(function()
			theme.drawTextEntryPressed(textEntry.text,textEntry._offset,textEntry._cursor,x,y,w,h)
		end)
	elseif uiState.hotItem==id then
		love.mouse.setCursor(love.mouse.getSystemCursor('ibeam'))
		DrawCommands.registerCommand(function()
			theme.drawTextEntryHover(textEntry.text,textEntry._offset,textEntry._cursor,x,y,w,h)
		end)
	else
		love.mouse.setCursor()
		DrawCommands.registerCommand(function()
			theme.drawTextEntryNormal(textEntry.text,textEntry._offset,textEntry._cursor,x,y,w,h)
		end)
	end
	return uiState.keyDown=='return' or uiState.keyDown=='enter'
end

return TextEntry