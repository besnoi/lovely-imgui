local CORE_PATH = (...)

imgui=require(CORE_PATH..'.base')

function imgui.init()
	love.keyboard.setKeyRepeat(true)
end

function imgui.isMouseReleased()
	return imgui.uiState.mouseUp
end

function imgui.getNextID()
	--this will get the ID of the next widget!
	return imgui['_genID']+1
end

return imgui