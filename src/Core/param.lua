--[[
	Since Magic-Numbers are bad we'll take care of them here!
]]

local param={}

function param.getStepperHeight(w) return w*.25 end

function param.getStepperLeftButton(stepper,x,y,w,h)
	return x,y,w*.2,h
end

function param.getStepperRightButton(stepper,x,y,w,h)
	return x+w-w*.2,y,w*.2,h
end

return param