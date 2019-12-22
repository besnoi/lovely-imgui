imgui=require 'imgui'
love.graphics.setBackgroundColor(.6,.6,.6)

function love.update(dt)
	imgui.update(dt)
	imgui.layout.setCursor(100,200)
	imgui.layout.setColumns(2)
	imgui.button('Button 1',400,100)
	imgui.button('Button 2',200,100)
	imgui.layout.setColumns(6)
	for i=1,5 do imgui.button('Button '..2+i) end
	imgui.button('!')
end
