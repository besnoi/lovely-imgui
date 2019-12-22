--[[
	The thing about primitive theme is that it's more efficient!
]]

local ASSETS_PATH=(...):gsub('[.]','/')..'/assets/'

local LIB_PATH=(...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local param=require(LIB_PATH..'.Core.param')

local theme={}
local lg,ef=love.graphics,function() end

theme.update=ef

local nc,hc,ac={.5,.5,.5},{.55,.55,.55},{.45,.45,.45}

--For Primitive theme, all widgets will have same color palette!
theme.normalColor=nc
theme.hotColor=hc
theme.activeColor=ac

-- For Primitive Theme, all widgets will have same font but you can change this if you like!
theme.font=lg.newFont(ASSETS_PATH..'roboto.ttf',15)
theme.arrowFont=lg.newFont(ASSETS_PATH..'roboto.ttf',20) --for arrows only

--[[
	Widgets can have different fonts but as a rule they must have
	the same font across different states (hovered,clicked,etc)
	getFontSize takes in the type of the widget and the text
	and returns the minimum-size that is required by that text!
	[Themes can be malice and return a greater or lower size!]
]]

function theme.getFontSize(widget,text)
	local w,h=theme.font:getWidth(text),theme.font:getHeight()
	if widget=='button' then
		w,h=w+50,h+30
	end
	return w,h
end

function theme.drawOutline(widget,x,y,w,h)
	if widget=='button' then return end
	lg.setColor(0,.1,.1)
	lg.rectangle('line',x,y,w,h)
end

---------------------HELPER FUNCTIONS-----------------------

local function constrain(value,min,max)
	return math.min(max,math.max(value,min))
end

local function drawButtonText(text,x,y,w,h)
	lg.setColor(.8,.8,.8)
	lg.setFont(theme.font)
	lg.printf(text,x,y+(h-theme.font:getHeight())/2,w,'center')
end

local function drawTick(x,y,w,h)
	lg.setLineStyle('smooth')
	lg.setLineWidth(w/16)
	lg.setLineJoin("bevel")
	lg.line(x+h*.2,y+h*.6, x+h*.45,y+h*.75, x+h*.8,y+h*.2)
	lg.setLineWidth(1)
end

local function drawCheckBoxText(text,x,y,h)
	lg.setColor(.2,.2,.2)
	lg.setFont(theme.font)
	lg.print(text,x,y+(h-theme.font:getHeight())/2)
end

local drawRadioButtonText=drawCheckBoxText

------------------------STEPPER------------------------

function theme.drawStepperNormal(stepper,x,y,w,h)
	local lx,ly,lw,lh=param.getStepperLeftButton(stepper,x,y,w,h)
	local rx,ry,rw,rh=param.getStepperRightButton(stepper,x,y,w,h)
	ly=ly-2 ry=ry-2
	lg.setColor(nc[1]-.05,nc[2]-.05,nc[3]-.05)
	lg.rectangle('fill',lx,ly,lw,lh+6,4,4)
	lg.rectangle('fill',rx,ry,rw,rh+6,4,4)
	lg.setColor(nc[1]+.03,nc[2]+.03,nc[3]+.03)
	lg.rectangle('fill',x,y,w,h,4,4)
	lg.setColor(unpack(nc))
	lg.rectangle('fill',lx,ly,lw,lh+2,4,4)
	lg.rectangle('fill',rx,ry,rw,rh+2,4,4)
	lg.setColor(.2,.2,.2)
	lg.setColor(.8,.8,.8)
	lg.setFont(theme.font)
	lg.printf(stepper.list[stepper.active],x,y+(h-theme.font:getHeight())/2,w,'center')
	lg.setColor(.7,.7,.7)
	lg.setFont(theme.arrowFont)
	lg.printf('>',rx,ry+(rh-theme.font:getHeight())/2,rw,'center')
	lg.printf('<',lx,ly+(lh-theme.font:getHeight())/2,lw,'center')
end

function theme.drawStepperHover(stepper,left_hovered,x,y,w,h)
	local lx,ly,lw,lh=param.getStepperLeftButton(stepper,x,y,w,h)
	local rx,ry,rw,rh=param.getStepperRightButton(stepper,x,y,w,h)
	ly=ly-2 ry=ry-2
	lg.setColor(nc[1]-.05,nc[2]-.05,nc[3]-.05)
	lg.rectangle('fill',lx,ly,lw,lh+6,4,4)
	lg.rectangle('fill',rx,ry,rw,rh+6,4,4)
	lg.setColor(nc[1]+.03,nc[2]+.03,nc[3]+.03)
	lg.rectangle('fill',x,y,w,h,4,4)
	lg.setColor(unpack(nc))
	if left_hovered then lg.setColor(unpack(hc)) end
	lg.rectangle('fill',lx,ly,lw,lh+2,4,4)
	lg.setColor(unpack(nc))
	if not left_hovered then lg.setColor(unpack(hc)) end
	lg.rectangle('fill',rx,ry,rw,rh+2,4,4)
	lg.setColor(.2,.2,.2)
	lg.setColor(.8,.8,.8)
	lg.setFont(theme.font)
	lg.printf(stepper.list[stepper.active],x,y+(h-theme.font:getHeight())/2,w,'center')
	lg.setColor(.7,.7,.7)
	lg.setFont(theme.arrowFont)
	lg.printf('>',rx,ry+(rh-theme.font:getHeight())/2,rw,'center')
	lg.printf('<',lx,ly+(lh-theme.font:getHeight())/2,lw,'center')
end

function theme.drawStepperPressed(stepper,left_pressed,x,y,w,h)
	local lx,ly,lw,lh=param.getStepperLeftButton(stepper,x,y,w,h)
	local rx,ry,rw,rh=param.getStepperRightButton(stepper,x,y,w,h)
	ly=ly-2 ry=ry-2
	lg.setColor(nc[1]-.05,nc[2]-.05,nc[3]-.05)
	lg.rectangle('fill',lx,ly,lw,lh+6,4,4)
	lg.rectangle('fill',rx,ry,rw,rh+6,4,4)
	lg.setColor(nc[1]+.03,nc[2]+.03,nc[3]+.03)
	lg.rectangle('fill',x,y,w,h,4,4)
	lg.setColor(unpack(nc))
	if left_pressed then lg.setColor(unpack(ac)) end
	lg.rectangle('fill',lx,ly,lw,lh+2,4,4)
	lg.setColor(unpack(nc))
	if not left_pressed then lg.setColor(unpack(ac)) end
	lg.rectangle('fill',rx,ry,rw,rh+2,4,4)
	lg.setColor(.2,.2,.2)
	lg.setColor(.8,.8,.8)
	lg.setFont(theme.font)
	lg.printf(stepper.list[stepper.active],x,y+(h-theme.font:getHeight())/2,w,'center')
	lg.setColor(.7,.7,.7)
	lg.setFont(theme.arrowFont)
	lg.printf('>',rx,ry+(rh-theme.font:getHeight())/2,rw,'center')
	lg.printf('<',lx,ly+(lh-theme.font:getHeight())/2,lw,'center')
end

-----------------------TEXT ENTRY----------------------

function theme.drawTextEntryNormal(text,offset,cursor,x,y,w,h)
	lg.setColor(unpack(nc))
	lg.rectangle('fill',x,y,w,h,4,4)
	lg.setFont(theme.font)
	lg.setColor(1,1,1)
	lg.setScissor(x,y,w,h)
	lg.setColor(.8,.8,.8)
	lg.print(text,x+3,y+(h-theme.font:getHeight())/2)
	lg.setScissor()
end

function theme.drawTextEntryHover(text,offset,cursor,x,y,w,h)
	lg.setColor(unpack(hc))
	lg.rectangle('fill',x,y,w,h,4,4)
	lg.setFont(theme.font)
	lg.setColor(1,1,1)
	lg.setScissor(x,y,w,h)
	lg.setColor(.8,.8,.8)
	lg.print(text,x+3,y+(h-theme.font:getHeight())/2)
	lg.setScissor()
end

function theme.drawTextEntryPressed(text,offset,cursor,x,y,w,h)
	lg.setColor(unpack(ac))
	lg.rectangle('fill',x,y,w,h,2,2)
	lg.setFont(theme.font)
	lg.setColor(1,1,1)
	local left=text:sub(1,cursor)
	local fontWidth=math.ceil((theme.font:getWidth(left)-w)/text:len())
	local right=theme.font:getWidth(left)>w and text:sub(fontWidth,cursor) or text
	lg.setScissor(x,y,w,h)
	if love.timer.getTime()%1.5<=1 then
		lg.print('|',x+3+theme.font:getWidth(left),y+(h-theme.font:getHeight())/2)
	end
	lg.setColor(.8,.8,.8)
	lg.print(right,x+3,y+(h-theme.font:getHeight())/2)
	lg.setScissor()
end

-------------------------LABEL-------------------------

function theme.drawLabel(text,x,y)
	lg.setColor(.8,.8,.8)
	lg.setFont(theme.font)
	lg.print(text,x,y)
end

-------------------------TOOLTIP-------------------------

function theme.drawTooltip(text,x,y)
	lg.setColor(0,0,0)
	lg.rectangle('fill',x-4,y-2,theme.font:getWidth(text)+8,theme.font:getHeight()+2)
	lg.setColor(.8,.8,.8)
	lg.setFont(theme.font)
	lg.print(text,x,y)
end

--TODO Ask GFG if I can write a detailed tutorial on ImGUI!

-----------------------MENU BAR------------------------

function theme.drawMenuBar(x,y,w,h)
	lg.setColor(unpack(nc))
	lg.rectangle('fill',x,y,w,h+4)
end

-------------------------MENUS-------------------------

function theme.drawMenuNormal(text,x,y)
	lg.setColor(.8,.8,.8)
	lg.setFont(theme.font)
	lg.print(text,x,y+2)
end

function theme.drawMenuHover(text,x,y,w,h)
	lg.setColor(unpack(hc))
	lg.rectangle('fill',x-5,y,w+1,h+4)
	lg.setColor(.8,.8,.8)
	lg.setFont(theme.font)
	lg.print(text,x,y+2)
end

----------------------PROGRESS BAR----------------------

function theme.drawProgressBar(text,value,x,y,w,h)
	lg.setColor(unpack(nc))
	lg.rectangle('fill', x,y,w,h,2,2)
	w = w * value
	lg.setColor(.3,.3,.5)
	if value>0 then
		lg.rectangle('fill',x,y,w,h,2,2)
	end
end

----------------------SCALER WIDGET---------------------

function theme.drawScalerNormal(fraction,orientation,x,y,w,h)
	lg.setColor(unpack(nc))
	lg.rectangle('fill', x,y,w,h,2,2)

	if orientation=='t-b' or orientation=='b-t' then
		if orientation=='b-t' then y=y+h*(1-fraction) end
		h = h * fraction
	else
		if orientation=='l-r' then x=x+w*(1-fraction) end
		w = w * fraction
	end

	lg.setColor(nc[1]-.1,nc[2]-.1,nc[3]-.1)
	if fraction>0 then
		lg.rectangle('fill',x,y,w,h,2,2)
	end
end

function theme.drawScalerHover(fraction,orientation,x,y,w,h)
	lg.setColor(unpack(hc))
	lg.rectangle('fill', x,y,w,h,2,2)

	if orientation=='t-b' or orientation=='b-t' then
		if orientation=='b-t' then y=y+h*(1-fraction) end
		h = h * fraction
	else
		if orientation=='l-r' then x=x+w*(1-fraction) end
		w = w * fraction
	end
	
	lg.setColor(hc[1]-.1,hc[2]-.1,hc[3]-.1)
	if fraction>0 then
		lg.rectangle('fill',x,y,w,h,2,2)
	end
end

function theme.drawScalerPressed(fraction,orientation,x,y,w,h)
	x=x+1 y=y+1
	lg.setColor(unpack(ac))
	lg.rectangle('fill', x,y,w,h,2,2)

	if orientation=='t-b' or orientation=='b-t' then
		if orientation=='b-t' then y=y+h*(1-fraction) end
		h = h * fraction
	else
		if orientation=='l-r' then x=x+w*(1-fraction) end
		w = w * fraction
	end

	lg.setColor(ac[1]-.1,ac[2]-.1,ac[3]-.1)
	if fraction>0 then
		lg.rectangle('fill',x,y,w,h,2,2)
	end
end

local THUMB_SIZE=25 --> some DRY coding! Doesn't matter much!

----------------------SLIDER WIDGET---------------------

function theme.drawSliderNormal(fraction,vertical,x,y,w,h)
	lg.setColor(unpack(nc))
	lg.rectangle('line', x,y,w,h,2,2)

	if vertical then
		y=constrain(y+h*fraction-THUMB_SIZE/2,y,y+h-THUMB_SIZE)
		h=THUMB_SIZE
	else
		x=constrain(x+w*fraction-THUMB_SIZE/2,x,x+w-THUMB_SIZE)
		w=THUMB_SIZE
	end

	lg.setColor(nc[1]-.1,nc[2]-.1,nc[3]-.1)
	lg.rectangle('fill',x,y,w,h,2,2)
end

function theme.drawSliderHover(fraction,vertical,x,y,w,h)
	lg.setColor(unpack(hc))
	lg.rectangle('line', x,y,w,h,2,2)

	if vertical then
		y=constrain(y+h*fraction-THUMB_SIZE/2,y,y+h-THUMB_SIZE)
		h=THUMB_SIZE
	else
		x=constrain(x+w*fraction-THUMB_SIZE/2,x,x+w-THUMB_SIZE)
		w=THUMB_SIZE
	end

	lg.setColor(hc[1]-.1,hc[2]-.1,hc[3]-.1)
	lg.rectangle('fill',x,y,w,h,2,2)
end

function theme.drawSliderPressed(fraction,vertical,x,y,w,h)
	-- x=x+1 y=y+1
	lg.setColor(unpack(ac))
	lg.rectangle('line', x,y,w,h,2,2)

	if vertical then
		y=constrain(y+h*fraction-THUMB_SIZE/2,y,y+h-THUMB_SIZE)
		h=THUMB_SIZE
	else
		x=constrain(x+w*fraction-THUMB_SIZE/2,x,x+w-THUMB_SIZE)
		w=THUMB_SIZE
	end

	lg.setColor(ac[1]-.1,ac[2]-.1,ac[3]-.1)
	lg.rectangle('fill',x,y,w,h,2,2)
end

-------------------RADIOBUTTON WIDGET----------------------

function theme.drawRadioButtonNormal(isChecked,text,x,y,w,h)
	lg.setColor(nc[1]-.15,nc[2]-.15,nc[3]-.15)
	lg.setLineWidth(3)
	lg.ellipse('line',x+w/2,y+h/2,w/2,h/2,40)
	lg.setLineWidth(1)
	lg.setColor(unpack(nc))
	lg.ellipse('fill',x+w/2,y+h/2,w/2-2,h/2-2)
	if text then drawRadioButtonText(text,x+w+10,y,h) end
	if isChecked then
		lg.setColor(nc[1]-.25,nc[2]-.25,nc[3]-.25)
		lg.ellipse('fill',x+w/2,y+h/2,w/2-math.floor(1+w/5),h/2-math.floor(1+h/5),40)
	end
end

function theme.drawRadioButtonHover(isChecked,text,x,y,w,h)
	lg.setColor(hc[1]-.15,hc[2]-.15,hc[3]-.15)
	lg.setLineWidth(3)
	lg.ellipse('line',x+w/2,y+h/2,w/2,h/2,40)
	lg.setLineWidth(1)
	lg.setColor(unpack(hc))
	lg.ellipse('fill',x+w/2,y+h/2,w/2-2,h/2-2)
	if text then drawRadioButtonText(text,x+w+10,y,h) end
	if isChecked then
		lg.setColor(hc[1]-.25,hc[2]-.25,hc[3]-.25)
		lg.ellipse('fill',x+w/2,y+h/2,w/2-math.floor(1+w/5),h/2-math.floor(1+h/5),40)
	end
end

function theme.drawRadioButtonPressed(isChecked,text,x,y,w,h)
	y=y+1
	lg.setColor(ac[1]-.2,ac[2]-.2,ac[3]-.2)
	lg.setLineWidth(3)
	lg.ellipse('line',x+w/2,y+h/2,w/2,h/2,40)
	lg.setLineWidth(1)
	lg.setColor(ac[1]-.05,ac[2]-.05,ac[3]-.05)
	lg.ellipse('fill',x+w/2,y+h/2,w/2-2,h/2-2)
	if text then drawRadioButtonText(text,x+w+10,y-1,h) end
	if isChecked then
		lg.setColor(ac[1]-.15,ac[2]-.15,ac[3]-.15)
		lg.ellipse('fill',x+w/2,y+h/2,w/2-math.floor(1+w/5),h/2-math.floor(1+h/5),40)
	end
end

-------------------CHECKBOX WIDGET----------------------

function theme.drawCheckBoxNormal(isChecked,text,x,y,w,h)
	lg.setColor(nc[1]-.05,nc[2]-.05,nc[3]-.05)
	lg.rectangle('fill',x,y,w,h+math.floor(1+h/16),2,2)
	lg.setColor(unpack(nc))
	lg.rectangle('fill',x,y,w,h,2,2)
	if text then drawCheckBoxText(text,x+w+10,y,h) end
	if isChecked then
		lg.setColor(.3,.3,.3)
		drawTick(x,y,w,h)
	end
end

function theme.drawCheckBoxHover(isChecked,text,x,y,w,h)
	lg.setColor(hc[1]-.05,hc[2]-.05,hc[3]-.05)
	lg.rectangle('fill',x,y,w,h+math.floor(1+h/16),2,2)
	lg.setColor(unpack(hc))
	lg.rectangle('fill',x,y,w,h,2,2)
	if text then drawCheckBoxText(text,x+w+10,y,h) end
	if isChecked then
		lg.setColor(.3,.3,.3)
		drawTick(x,y,w,h)
	end
end

function theme.drawCheckBoxPressed(isChecked,text,x,y,w,h)
	lg.setColor(ac[1]-.15,ac[2]-.15,ac[3]-.15)
	lg.rectangle('fill',x,y+2,w,h-2+math.floor(1+h/16),2,2)
	lg.setColor(unpack(ac))
	lg.rectangle('fill',x,y+2,w,h-2,2,2)
	if text then drawCheckBoxText(text,x+w+10,y,h) end
	if isChecked then
		lg.setColor(.3,.3,.3)
		drawTick(x,y+2,w,h)
	end
end

-------------------BUTTON WIDGET----------------------

function theme.drawButtonNormal(text,x,y,w,h)
	lg.setColor(nc[1]-.05,nc[2]-.05,nc[3]-.05)
	lg.rectangle('fill',x,y,w,h+6,5,5)
	lg.setColor(unpack(nc))
	lg.rectangle('fill',x,y,w,h,5,5)
	drawButtonText(text,x,y,w,h)
end

function theme.drawButtonHover(text,x,y,w,h)
	lg.setColor(hc[1]-.05,hc[2]-.05,hc[3]-.05)
	lg.rectangle('fill',x,y,w,h+6,5,5)
	lg.setColor(unpack(hc))
	lg.rectangle('fill',x,y,w,h,5,5)
	drawButtonText(text,x,y,w,h)
end

function theme.drawButtonPressed(text,x,y,w,h)
	lg.setColor(ac[1]-.1,ac[2]-.1,ac[3]-.1)
	lg.rectangle('fill',x,y+3,w,h+3,5,5)
	lg.setColor(unpack(ac))
	lg.rectangle('fill',x,y+3,w,h-3,5,5)
	drawButtonText(text,x,y+2,w,h)
end

return theme