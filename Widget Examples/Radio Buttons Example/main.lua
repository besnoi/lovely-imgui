imgui=require 'imgui'

love.graphics.setBackgroundColor(.6,.6,.6)

function love.update(dt)
	imgui.update(dt)
end
local group1,group2={},{}
local radioButton1={active=true,group=group1}
local radioButton2={group=group1}
local radioButton3={group=group1}
local radioButton4={group=group2}
local radioButton5={group=group2} -->try doing group=nil!
group1[1],group1[2],group1[3]=radioButton1,radioButton2,radioButton3
group2[1],group2[2]=radioButton4,radioButton5

-- radioButton4={active=false} --> doesn't belong to any group!

function love.draw()
	imgui.layout.setCursor(300,200)

	imgui.radioButton(radioButton1,'I am radio button #1 (group 1)')
	imgui.radioButton(radioButton2,'I am radio button #2 (group 1)')
	imgui.radioButton(radioButton3,'I am radio button #3 (group 1)')

	imgui.layout.setPosition(0,20,true)
	imgui.radioButton(radioButton4,'I am radio button #4 (group 2)')
	imgui.radioButton(radioButton5,'I am radio button #5 (group 2)')
	imgui.draw()
end