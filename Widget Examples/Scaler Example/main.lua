imgui=require 'imgui'

love.graphics.setBackgroundColor(.6,.6,.6)

function love.update(dt)
	imgui.update(dt)
end
local scaler1={orientation='t-b'}
local scaler2={orientation='b-t'}
local scaler3={orientation='l-r'}
local scaler4={} --same as orientation set to 'l-r'

function love.draw()
	imgui.layout.setCursor(300,200)
	imgui.layout.setColumns(4)
	imgui.tooltip('I am a Top-to-Bottom Scaler')
	imgui.scaler(scaler1,100)
	imgui.tooltip('I am a Bottom-to-Top Scaler')
	imgui.scaler(scaler2,100)
	imgui.tooltip('I go from Left-to-Right')
	imgui.scaler(scaler3,100)
	imgui.tooltip('I am completely normal!')
	imgui.scaler(scaler4,100)
	imgui.draw()
end
