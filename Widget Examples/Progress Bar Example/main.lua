imgui=require 'imgui'

love.graphics.setBackgroundColor(.6,.6,.6)
--IMPORTANT: Widgets like Progress Bar need to be updated at every frame
--The default optimization can hinder in the process
imgui.noOptimize()
--You can try removing this to see what happens?

function love.update(dt)
	imgui.update(dt)
end
local progress={}

function love.draw()
	imgui.progressBar(progress,250)
	imgui.layout.setColumns(2)
	if imgui.button(stopped and "Resume" or "Stop",100,48) then
		if imgui.isMouseReleased() then --execute this block only once!!
			stopped=not stopped
			if stopped then
				progress.update=function() return 0 end
			else
				progress.update=function(dt) return dt/5 end --5s delay
			end
		end
	end
	if imgui.button("Restart") then
		progress.value=0
	end
	
	imgui.draw()
end
