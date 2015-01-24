Map = class("Map")

function Map:initialize(filename)
	print(filename)
	raw = loadfile(filename)
end
