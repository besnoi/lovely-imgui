--[[
	ImGUI needs window-dimensions, cursor-positon, etc
	So UIState stores all these information!
]]

--Setting default values *just in case*!!

local UIState={
	dt,        --delta-time
	mouseX=-100,
	mouseY=-100,
	keyChar,   --for text input
	scrollDX,
	scrollDY,
	mouseUp,   --meant to be used externally through an interface!
	mouseDown,  --used internally
	hotItem,
	activeItem,
	lastActiveItem,
	winWidth,
	winHeight
}

return UIState