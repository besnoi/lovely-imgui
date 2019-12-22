--[[
	lovely-imgui V. 1.0 (beta)
	Author: Neer (https://github.com/YoungNeer/lovely-imgui)
]]

local LIB_PATH=(...)

local imgui=require(LIB_PATH..'.Core')

imgui.label=require(LIB_PATH..'.Widgets.Label')
imgui.button=require(LIB_PATH..'.Widgets.Button')
imgui.tooltip=require(LIB_PATH..'.Widgets.Tooltip')
imgui.checkBox=require(LIB_PATH..'.Widgets.CheckBox')
imgui.radioButton=require(LIB_PATH..'.Widgets.RadioButton')
imgui.progressBar=require(LIB_PATH..'.Widgets.ProgressBar')
imgui.image=require(LIB_PATH..'.Widgets.Image')
imgui.imageButton=require(LIB_PATH..'.Widgets.ImageButton')
imgui.scaler=require(LIB_PATH..'.Widgets.Scaler')
imgui.slider=require(LIB_PATH..'.Widgets.Slider')
imgui.stepper=require(LIB_PATH..'.Widgets.Stepper')
imgui.textEntry=require(LIB_PATH..'.Widgets.TextEntry')
imgui.canvas=imgui.image --you can also draw canvas!
imgui.beginMenuBar=require(LIB_PATH..'.Widgets.MenuBar')[1]
imgui.endMenuBar=require(LIB_PATH..'.Widgets.MenuBar')[2]
imgui.beginMenu=require(LIB_PATH..'.Widgets.Menu')[1]
imgui.endMenu=require(LIB_PATH..'.Widgets.Menu')[2]

-- assetLoader=require(LIB_PATH..'.Core.assetLoader')
-- require(LIB_PATH..'.Themes.Light')

love.draw = love.draw or imgui.draw
love.update = love.update or imgui.update
love.mousepressed = love.mousepressed or imgui.mousepressed
love.keypressed = love.keypressed or imgui.keypressed
love.mousereleased = love.mousereleased or imgui.mousereleased
love.keyreleased = love.keyreleased or imgui.keyreleased
love.mousemoved = love.mousemoved or imgui.mousemoved
love.resize = love.resize or imgui.resize
love.textinput = love.textinput or imgui.textinput

return imgui
