imgui=require 'imgui'
love.graphics.setBackgroundColor(.6,.6,.6)

function love.update(dt)
	imgui.update(dt)
	if imgui.button('Click here!!',400,300,200,70) then
		imgui.label('You pressed the button!',400,360)
	end
end

