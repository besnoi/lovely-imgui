imgui=require 'imgui'
love.window.setMode(800,600,{
	minwidth=200,
	minheight=200,
	resizable=true
})
imgui.noOptimize()
love.window.setTitle('lovely-imgui Responsive Test')
love.graphics.setBackgroundColor(.6,.6,.6)
function love.update(dt)
	imgui.update(dt)
end

function love.draw()
	imgui.image('button.png','.5','.5',50,50)
	imgui.image('button.png','.5','.25',50,50)
	imgui.image('button.png','.5','.75',50,50)
	imgui.image('button.png','.25','.5',50,50)
	imgui.image('button.png','.75','.5',50,50)
	imgui.draw()
end