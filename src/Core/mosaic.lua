--[[
	[DISCLAIMER: Stolen from Luigi! Credit:Airstruck ]
	
	Mosaic's main job is to cut slices which are then
	used when rendering a widget which is done by it as well!
	This module is also responsible for maintaining a img-cache
]]

local Mosaic={}

local imgCache = {}
local sliceCache = {}

function Mosaic.loadImage (path)
    if not imgCache[path] then
        imgCache[path] = love.graphics.newImage(path)
    end
    return imgCache[path]
end

local makeSlice = love.graphics.newQuad
local drawSlice=love.graphics.draw

function Mosaic.loadSlices (path)
    local slices = sliceCache[path]

    if not slices then
        slices = {}
        sliceCache[path] = slices
        local image = Mosaic.loadImage(path)
        local iw, ih = image:getWidth(), image:getHeight()
        local w, h = math.floor(iw / 3), math.floor(ih / 3)

        slices.image = image
        slices.width = w
        slices.height = h

        slices.topLeft = makeSlice(0, 0, w, h, iw, ih)
        slices.topCenter = makeSlice(w, 0, w, h, iw, ih)
        slices.topRight = makeSlice(iw - w, 0, w, h, iw, ih)
        slices.middleLeft = makeSlice(0, h, w, h, iw, ih)
        slices.middleCenter = makeSlice(w, h, w, h, iw, ih)
        slices.middleRight = makeSlice(iw - w, h, w, h, iw, ih)
        slices.bottomLeft = makeSlice(0, ih - h, w, h, iw, ih)
        slices.bottomCenter = makeSlice(w, ih - h, w, h, iw, ih)
        slices.bottomRight = makeSlice(iw - w, ih - h, w, h, iw, ih)
    end
    return slices
end

function Mosaic.draw(img,slices,x,y,w,h)
    local sw, sh = slices.width, slices.height
    local xs = (w - sw * 2) / sw -- x scale
    local ys = (h - sh * 2) / sh -- y scale

    drawSlice(img,slices.middleCenter, x + sw, y + sh, 0, xs, ys)
    drawSlice(img,slices.topCenter, x + sw, y, 0, xs, 1)
    drawSlice(img,slices.bottomCenter, x + sw, y + h - sh, 0, xs, 1)
    drawSlice(img,slices.middleLeft, x, y + sh, 0, 1, ys)
    drawSlice(img,slices.middleRight, x + w - sw, y + sh, 0, 1, ys)
    drawSlice(img,slices.topLeft, x, y)
    drawSlice(img,slices.topRight, x + w - sw, y)
    drawSlice(img,slices.bottomLeft, x, y + h - sh)
    drawSlice(img,slices.bottomRight, x + w - sw, y + h - sh)
end

return Mosaic