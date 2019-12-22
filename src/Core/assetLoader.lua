--[[
	Whole point -> to load all the assets at one go!!
	Here Assets refer to quads and PNG images!
]]

local AssetLoader={}
local imgCache={}
local slicesCache={}

local CORE_PATH = (...):match("^(.+)%.[^%.]+")
local Mosaic=require(CORE_PATH..'.mosaic')

local function isAFile(url)
	if love.filesystem.getInfo(url) then
		return love.filesystem.getInfo(url).type=="file"
	end
end

local function masterLoad(path,func)
	path=path:gsub('[.]','/')
	local assets={}
	local items=love.filesystem.getDirectoryItems(path)
	for i,item in ipairs(items) do
		if not isAFile(path..'/'..item) then
			goto continue
		end
		local len=item:len()
		if len>4 and item:sub(len-3)=='.png' then
			assets[item:sub(1,item:len()-4)]=func(path..'/'..item)
		end
		::continue::
	end
	return assets
end

function AssetLoader.loadImages(path)
	if not imgCache[path] then
		imgCache[path]=masterLoad(path,Mosaic.loadImage)
	end
	return imgCache[path]
end

function AssetLoader.loadSlices(path)
	if not slicesCache[path] then
		slicesCache[path]=masterLoad(path,Mosaic.loadSlices)
	end
	return slicesCache[path]
end

return AssetLoader