imgui=require 'imgui'

love.window.setMode(640,480,{resizable=true})
love.window.setTitle('lovely-imgui Responsive Test')

function love.update(dt)
	imgui.update(dt)
	imgui.button('hello world','center','center',.5,.5)
end
