--[[
	How should a button be rendered when it's hovered, etc?
	All of this done by the (current) theme!
]]

local LIB_PATH=(...):
	match("^(.+)%.[^%.]+"):
	match("^(.+)%.[^%.]+")

local theme={
	current,
	list={}
}

theme.list['default']=require(LIB_PATH..'.Themes.Primitive')

--[[
	Every widget will have an outline that
	depending on theme may or may not get drawn!
]]
local funcs={
	'update','getFontSize','drawButtonNormal','drawButtonHover',
	'drawButtonPressed','drawCheckBoxNormal',
	'drawCheckBoxHover','drawCheckBoxPressed','drawRadioButtonNormal',
	'drawRadioButtonHover','drawRadioButtonPressed','drawScalerNormal',
	'drawScalerHover','drawScalerPressed',
	'drawLabel','drawTooltip','drawProgressBar','drawMenuBar','drawMenuNormal',
	'drawMenuHover','drawSliderNormal','drawSliderHover','drawSliderPressed',
	'drawTextEntryNormal','drawTextEntryHover','drawTextEntryPressed',
	'drawStepperNormal','drawStepperHover','drawStepperPressed',
	'drawOutline',
}

theme.set=function(themeName)
	theme.current=theme.list[themeName]
	--So rendering the theme will simply render the current theme!
	for _,func in ipairs(funcs) do
		theme[func]=theme.current[func]
	end
end

theme.set('default')

--[[
	Why theme.update(dt)???
	You know that themes not just affect appearance but also performance!
	And themes can just change the "look" but also the "feel" which
	makes them so similar to Java's LAF! With update, one can do tweening
	for a widget transition! (button-hover,etc!)

	Why onActivate and onDeactivate?
	So that themes can turn on/off idle-mode, piano-mode and canvas-rendering
	(eg. canvas-rendering is on by default and is good for performance but is
	sometimes bad for appearance hence a theme may disable it and enable it
	when it is switched!!)
]]

return theme