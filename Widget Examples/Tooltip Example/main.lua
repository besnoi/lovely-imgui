imgui=require 'imgui'

imgui.noOptimize()
love.graphics.setBackgroundColor(.6,.6,.6)

function love.update(dt)
	imgui.update(dt)
end
function love.draw()
	imgui.tooltip('I am a tooltip!!!')
	if imgui.button('hello world','center','center',100,100) then
		if imgui.btnReleased then
			print('working')
		end
	end
	imgui.draw()
end
