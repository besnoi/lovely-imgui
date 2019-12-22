imgui=require 'imgui'
love.window.setMode(800,600,{
	minwidth=150,
	minheight=150,
	resizable=true
})
love.graphics.setBackgroundColor(.6,.6,.6)
function love.update(dt)
	imgui.update(dt)
end

function love.draw()
	imgui.image('button.png','left','top',50,50)
	imgui.image('button.png','center','top',50,50)
	imgui.image('button.png','right','top',50,50)
	imgui.image('button.png','left','center',50,50)
	imgui.image('button.png','center','center',50,50)
	imgui.image('button.png','right','center',50,50)
	imgui.image('button.png','left','bottom',50,50)
	imgui.image('button.png','center','bottom',50,50)
	imgui.image('button.png','right','bottom',50,50)
	imgui.draw()
end