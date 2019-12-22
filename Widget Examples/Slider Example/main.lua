imgui=require 'imgui'

love.graphics.setBackgroundColor(.6,.6,.6)
imgui.noOptimize()

function love.update(dt)
	imgui.update(dt)
end

local slider={value=0,vertical=true}
local layoutTest,progress={},{}

function love.draw()
	imgui.layout.setColumns(2)
	imgui.layout.setCursor(300,200)
	imgui.slider(slider,100)
	if progress[1] then
		imgui.progressBar(slider,100,25)
	else
		imgui.scaler(slider,100)
	end
	if imgui.checkBox(layoutTest,'Layout Test') then
		slider.vertical=not slider.vertical
	end
	if imgui.checkBox(progress,'Progress') then
		-- slider.vertical=not slider.vertical
	end
	imgui.draw()
end