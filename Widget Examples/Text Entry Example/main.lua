local input={limit=11}

function love.load()
    imgui = require 'imgui'
    imgui.init()
end

function love.draw()
    imgui.textEntry(input,'center','center',200)
    imgui.draw()
end

function love.textinput(text)
    imgui.textinput(text)
end