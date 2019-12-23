imgui=require 'imgui'

love.graphics.setBackgroundColor(.6,.6,.6)
love.window.setMode(800,600,{resizable=true})
love.window.setTitle('Lovely-ImGUI Layout Test')

function love.draw()
	imgui.layout.setFlex(true)
	imgui.layout.setCursor('.05','.1')
	imgui.layout.setColumns(7)
	imgui.button('HTML5')
	imgui.button('CSS3')
	imgui.button('Javascript')
	imgui.button('PHP')
	imgui.button('Lua')
	imgui.button('Ruby')
	imgui.button('Python')
	imgui.draw()
end