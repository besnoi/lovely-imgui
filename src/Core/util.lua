--[[
	We need some utility functions such as pointInRect etc!
	So that's the whole purpose of this util.lua!
]]

local util={}
local CORE_PATH=(...):match("^(.+)%.[^%.]+")
local LIB_PATH=CORE_PATH:match("^(.+)%.[^%.]+")
local uiState=require(CORE_PATH..'.UIState')
local param=require(CORE_PATH..'.param')
local mosaic=require(CORE_PATH..'.mosaic')
local theme=require(CORE_PATH..'.theme')
local Layout=require(LIB_PATH..'.Widgets.Layout')
local Window=require(LIB_PATH..'.Widgets.Window')

function util.warp(value,min,max)
	return value>max and min or (value<min and max or value)
end

function util.constrain(value,min,max)
	return math.min(max,math.max(value,min))
end

function util.pointInRect(x,y,w,h, x0,y0)
	return x<=x0 and x0<=x+w and y<=y0 and y0<=y+h
end

function util.mouseOver(x,y,w,h)
	if uiState.mouseX and uiState.mouseY then
		return util.pointInRect(
			x,y,w,h,uiState.mouseX,uiState.mouseY
		)
	end
end

--Takes in arguments and returns true if one of them is nil
function util.argsOverloaded(argn,...)
	if argn~=select('#',...) then
		return true
	end
	for i=1,argn do
		if select(i,...)==nil then
			return true
		end
	end
end

local function getXFromAlign(align,width)
	if type(align)=='string' then
		if align=='center' then return Window.getCenterX()
		elseif align=='left' then return Window.getLeft()+width/2
		elseif align=='right' then return Window.getRight()-width/2
		else
			local winW,winH=Window.getDimensions()
			return tonumber(align)*winW
		end
	else return align end
end

local function getYFromAlign(align,height)
	if type(align)=='string' then
		if align=='center' then return Window.getCenterY()
		elseif align=='top' then return Window.getTop()+height/2
		elseif align=='bottom' then return Window.getBottom()-height/2
		else
			local winW,winH=Window.getDimensions()
			return tonumber(align)*winH
		end
	else return align end
end

local function getFlexibleSize(w,h)
	local winW,winH=Window.getDimensions()
	if type(w)=='string' then w=winW*w end
	if type(h)=='string' then h=winH*h end
	return w,h
end


--[[
	---Overloads for imgui.image---
		#1: img,x,y,w,h
		#2: img,w,h           => x,y calc by Layout
		#3: img               => x,y calc by Layout, w,h=image_size
	img can be an Image or a table!
]]
function util.getImageParams(img,x,y,w,h)
	local color,r
	img=type(img)=='string' and mosaic.loadImage(img) or img

	if type(img)=='table' then
		color=img.color r=img.rotation img=img.image
	end


	if y and not w then
		--User gave us width and height but not x,y (#2)
		w,h=x,y x,y=nil
	elseif not x then
		--Calculate width and height (#3)
		w,h=img:getDimensions()
	end

	w,h=getFlexibleSize(w,h)
	
	if not x then
		x,y=Layout.getPosition(w,h) --Let layout do its job!!
	else
		x,y=getXFromAlign(x,w),getYFromAlign(y,h)
		--Images already have their origin centered in draw function
	end

	return img,color,r,x,y,w,h
end

--[[
	---Overloads for imgui.checkBox---
		#1: isChecked,text,x,y,w,h
		#2: isChecked,x,y,w,h       => text=nil
		#3: isChecked,text,w,h      => x,y calc by Layout
		#4: isChecked,w,h           => text=nil, x,y calc by Layout
		#5: isChecked               => x,y calc by Layout, w,h=16,16
]]

function util.getCheckBoxParams(isChecked,text,x,y,w,h)
	if type(text)=='number' then --#2 or #4
		x,y,w,h,text=text,x,y,w
	end
	if y and not w then  --#3 or #4
		w,h=x,y
		x,y=nil
	elseif not x then  --#5
		w,h=16,16
	end

	w,h=getFlexibleSize(w,h)

	if not x then
		x,y=Layout.getPosition(w+theme.getFontSize('checkbox',text)+10,h) --Let layout do its job!!
	else
		x,y=getXFromAlign(x,w)-w/2,getYFromAlign(y,h)-h/2
		--For Client: CheckBoxes have origin at the center!
	end

	return isChecked,text,x,y,w,h
end

util.getRadioButtonParams=util.getCheckBoxParams

--[[
	---Overloads for imgui.label---
		#1: text,x,y
		#2: text            => x,y calc by Layout
]]

function util.getLabelParams(text,x,y)
	local w,h
	if type(text)=='string' then
		w,h=theme.getFontSize('label',text)
	else
		w,h=text.font:getWidth(text.text),text.font:getHeight()
	end
	if not x then --#2
		x,y=Layout.getPosition(w,h) --Let layout do its job!!
	else --#1
		x,y=getXFromAlign(x,w)-w/2,getYFromAlign(y,h)-h/2
		--For Client: Labels have origin at the center!
	end
	return x,y
end

--[[
	---Overloads for imgui.tooltip---
		#1: text,x,y
		#2: text,x          => y default to mouseY
		#3: text            => x,y default to mouseX,mouseY
]]

function util.getTooltipParams(text,x,y)
	local w,h
	if type(text)=='string' then
		w,h=theme.getFontSize('tooltip',text)
	else
		w,h=text.font:getWidth(text.text),text.font:getHeight()
	end
	x=x and (getXFromAlign(x,w)-w/2) or uiState.mouseX
	y=y and (getYFromAlign(y,h)-h/2) or (uiState.mouseY+h)
	--For Client: Tooltips have origin at the center!
	return x,y
end


--[[
	---Overloads for imgui.button---
		#1: text,x,y,w,h    
		#2: text,w,h        => x,y calc by Layout
		#3: text            => x,y calc by Layout, w,h from Label
]]

function util.getButtonParams(text,x,y,w,h)
	if y and not w then
		--User gave us width and height but not x,y (#2)
		w,h=x,y x,y=nil
	elseif not w then
		--Get width and height from text (#3)
		w,h=theme.getFontSize('button',text)
	end
	w,h=getFlexibleSize(w,h)
	if not x then
		x,y=Layout.getPosition(w,h) --Let layout do its job!!
	else
		x,y=getXFromAlign(x,w)-w/2,getYFromAlign(y,h)-h/2
		--(#1) For Client: Buttons have origin at the center!
	end
	return text,x,y,w,h
end


--[[
	---Overloads for imgui.imageButton---
		#1: image,x,y,w,h    
		#2: image,w,h        => x,y calc by Layout
		#3: image            => x,y calc by Layout, w,h from image!
]]

function util.getImageButtonParams(img,x,y,w,h)
	if y and not w then
		--User gave us width and height but not x,y (#2)
		w,h=x,y x,y=nil
	elseif not w then
		--Get width and height from text (#3)
		w,h=img.image:getDimensions()
	end
	w,h=getFlexibleSize(w,h)
	if not x then
		x,y=Layout.getPosition(w,h) --Let layout do its job!!
	else
		x,y=getXFromAlign(x,w),getYFromAlign(y,h)
		--Images already have their origin centered in draw function
	end
	return x,y,w,h
end

--[[
	---Overloads for imgui.progressBar---
		#1: progress,x,y,w,h    
		#2: progress,w,h        => x,y calc by Layout
		#3: progress,w          => x,y calc by Layout, h default to 25
]]

function util.getProgressBarParams(progress,x,y,w,h)
	if y and not w then
		--User gave us width and height but not x,y (#2)
		w,h=x,y x,y=nil
	elseif x and not y then
		--Get width and set height to default (#3)
		w=x h=25 x=nil
	end
	w,h=getFlexibleSize(w,h)
	if not x then
		x,y=Layout.getPosition(w,h) --Let layout do its job!!
	else
		x,y=getXFromAlign(x,w)-w/2,getYFromAlign(y,h)-h/2
		--For Client: Progress Bars have origins in the center
	end
	return x,y,w,h
end

--[[
	---Overloads for imgui.scaler---
		#1: scaler,x,y,w,h    
		#2: scaler,w,h        => x,y calc by Layout
		#3: scaler,w/h        => x,y calc by Layout, h/w -> auto_calc
]]

function util.getScalerParams(scaler,x,y,w,h)
	if y and not w then
		--User gave us width and height but not x,y (#2)
		w,h=x,y x,y=nil
	elseif x and not y then
		--Calculate width/height from scaler (#3)
		if scaler.orientation=='t-b' or scaler.orientation=='b-t' then w,h=25,x
		else w,h=x,25 end
		x=nil
	end
	w,h=getFlexibleSize(w,h)
	if not x then
		x,y=Layout.getPosition(w,h) --Let layout do its job!!
	else
		x,y=getXFromAlign(x,w)-w/2,getYFromAlign(y,h)-h/2
	end

	scaler.min=scaler.min or 0
	scaler.max=scaler.max or 1
	scaler.value=scaler.value or scaler.min

	return x,y,w,h
end

--[[
	---Overloads for imgui.slider---
		#1: slider,x,y,w,h    
		#2: slider,x,y,w/h    => h/w -> auto_calc
		#2: slider,w,h        => x,y calc by Layout
		#3: slider,w/h        => x,y calc by Layout, h/w -> auto_calc
]]

local THUMB_SIZE=25 --DRY CODING!!! For now I guess it's alright

function util.getSliderParams(slider,x,y,w,h)
	if y and not w then
		--User gave us width and height but not x,y (#2)
		w,h=x,y x,y=nil
	elseif w and not h then
		--Calculate width/height automatically (#2)
		if slider.vertical then w,h=25,w
		else h=25 end
	elseif x and not y then
		--Calculate width/height from scaler (#3)
		if slider.vertical then w,h=25,x
		else w,h=x,25 end
		x=nil
	end
	w,h=getFlexibleSize(w,h)
	if not x then
		x,y=Layout.getPosition(w,h) --Let layout do its job!!
	else
		x,y=getXFromAlign(x,w)-w/2,getYFromAlign(y,h)-h/2
	end

	slider.min=slider.min or 0
	slider.max=slider.max or 1
	slider.value=slider.value or slider.min

	--Normalize the value of the slider!
	local fraction = (slider.value - slider.min) / (slider.max - slider.min)
	local sx,sy,sw,sh=x,y,w,h
	if slider.vertical then
		sy=util.constrain(y+h*fraction-THUMB_SIZE/2,y,y+h-THUMB_SIZE) sh=THUMB_SIZE
	else
		sx=util.constrain(x+w*fraction-THUMB_SIZE/2,x,x+w-THUMB_SIZE) sw=THUMB_SIZE
	end

	return fraction,x,y,w,h,sx,sy,sw,sh
end

--[[
	---Overloads for imgui.textEntry---
		#1: textEntry,x,y,w,h=30    
		#2: textEntry,w,h=30       => x,y calc by Layout
]]

function util.getTextEntryParams(textEntry,x,y,w,h)
	if x and not w then
		--User gave us width and height but not x,y (#2)
		w,h=x,y x,y=nil
	end
	w,h=getFlexibleSize(w,h or 30)
	if not x then
		x,y=Layout.getPosition(w,h) --Let layout do its job!!
	else
		x,y=getXFromAlign(x,w)-w/2,getYFromAlign(y,h)-h/2
	end
	textEntry.text=textEntry.text or ""
	textEntry._cursor=textEntry._cursor or 0
	return x,y,w,h
end


--[[
	---Overloads for imgui.stepper---
		#1: stepper,x,y,w,h=30    
		#2: stepper,w,h=30       => x,y calc by Layout
]]

function util.getStepperParams(stepper,x,y,w,h)
	if x and not w then
		--User gave us width and height but not x,y (#2)
		w,h=x,y x,y=nil
	end
	w,h=getFlexibleSize(w,h or param.getStepperHeight(w))
	if not x then
		x,y=Layout.getPosition(w,h) --Let layout do its job!!
	else
		x,y=getXFromAlign(x,w)-w/2,getYFromAlign(y,h)-h/2
	end
	stepper.list=stepper.list or {""}
	stepper.active=stepper.active or 1
	return x,y,w,h
end

return util