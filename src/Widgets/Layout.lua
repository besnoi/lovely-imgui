--[[
	Layout is not exactly a "widget"! You can't "draw a layout"!
	What Layout does is - it helps in setting the position and dimension of a widget
	relatively! Layout are "row-based" where each row is divided into columns.
	By default there's only on column but you can change that! There's also
	something such as the position of the layout and the padding of the layout!
]]

local WIDGETS_PATH = (...):match("^(.+)%.[^%.]+")

local Window=require(WIDGETS_PATH..'.Window')

local Layout={
	x=0,y=0;      --position of the layout
	cx=0,cy=0;    --position of the cursor
	rh=0;         --max. height of the current row
	px=4,py=9;    --layout padding! (has no effect on the first widget)
	cols=1;       --widgets are first placed column-wise then layout moves to the next-row!
	col=1;        --the current column! Layout will move to the next row when col>cols
}

--[[
	NOTE 1: An important thing about layouts is that they affect only future widget calls!!
	NOTE 2: There are no "rows"! Number of rows can be infinite (theoretically)!
]]

function Layout.setPadding(px,py)
	Layout.px,Layout.py=px,py
end

--Modified Copy from util.lua

local function getXFromAlign(align)
	if type(align)=='string' then
		if align=='center' then return Window.getCenterX()
		elseif align=='left' then return Window.getLeft()
		elseif align=='right' then return Window.getRight()
		else
			return tonumber(align)*Window.getDimensions()
		end
	else return align end
end

local function getYFromAlign(align)
	if type(align)=='string' then
		if align=='center' then return Window.getCenterY()
		elseif align=='top' then return Window.getTop()
		elseif align=='bottom' then return Window.getBottom()
		else
			local winW,winH=Window.getDimensions()
			return tonumber(align)*winH
		end
	else return align end
end


--Affects only the current row
function Layout.setPosition(x,y,relative)
	x=getXFromAlign(x) or (relative and 0 or Layout.x)
	y=getYFromAlign(y) or (relative and 0 or Layout.y)
	Layout.x,Layout.y=x+(relative and Layout.x or 0),y+(relative and Layout.y or 0)
end

--Affects all future rows
function Layout.setCursor(x,y,relative)
	Layout.cx,Layout.cy=x+(relative and Layout.cx or 0),y+(relative and Layout.cy or 0)
	Layout.setPosition(x,y,relative)
end

function Layout.setColumns(cols)
	Layout.cols=cols
end

function Layout.getPosition(w,h)
	local x,y=Layout.x,Layout.y
	if w then
		Layout.x=Layout.x+Layout.px+w
		Layout.col=Layout.col+1
		Layout.rh=math.max(Layout.rh,h)
		if Layout.col>Layout.cols then
			Layout.moveToNextRow(h)
		end
	end
	return x,y
end

function Layout.reset(x,y)
	Layout.setPadding(4,9)
	Layout.setCursor(x or 0, y or 0)
	Layout.cols,Layout.col=1,1
end

--Normally an internal function but can be used externally without any problem! (hopefully)
function Layout.moveToNextRow()
	Layout.x,Layout.col=Layout.cx,1
	Layout.y=Layout.y+Layout.py+Layout.rh
	Layout.rh=0
end

return Layout