local key_height = 50
local key_width = 50
local key_buffer = 10
local screen_w, screen_h = d2d.surface_size()
local start_x = 0
local start_y = screen_h - (key_height*4 + key_buffer*3)

local key = {pos_x = nil, pos_y = nil, size_x = nil, size_y = nil, text = nil, input = nil}

function key.new(pos_x, pos_y, size_x, size_y, text, input)
	local self = {}
	self.pos_x = pos_x or 0
	self.pos_y = pos_y or 0
	self.size_x = size_x or 0
	self.size_y = size_y or 0
	self.text = text or 0
	self.input = input or -1
	return self
end

local keys = {}
--[[layout of keyboard
		Q	W	E	R
		A	S 	D 	F
SHIFT	Z	X	C
CTRL	----SPACE----
]]

keys["Q"] = key.new(start_x+key_width*2+key_buffer*2, start_y+key_height*0+key_buffer*0, key_width, key_height, "Q", 0x51)
keys["W"] = key.new(start_x+key_width*3+key_buffer*3, start_y+key_height*0+key_buffer*0, key_width, key_height,"W", 0x57)
keys["E"] = key.new(start_x+key_width*4+key_buffer*4, start_y+key_height*0+key_buffer*0, key_width, key_height, "E", 0x45)
keys["R"] = key.new(start_x+key_width*5+key_buffer*5, start_y+key_height*0+key_buffer*0, key_width, key_height, "R", 0x52)
keys["M1"] = key.new(start_x+key_width*6+key_buffer*6, start_y+key_height*0+key_buffer*0, key_width, key_height, "M1", 0x01)
keys["M2"] = key.new(start_x+key_width*7+key_buffer*7, start_y+key_height*0+key_buffer*0, key_width, key_height, "M2", 0x02)
keys["A"] = key.new(start_x+key_width*2+key_buffer*2, start_y+key_height*1+key_buffer*1, key_width, key_height, "A", 0x41)
keys["S"] = key.new(start_x+key_width*3+key_buffer*3, start_y+key_height*1+key_buffer*1, key_width, key_height, "S", 0x53)
keys["D"] = key.new(start_x+key_width*4+key_buffer*4, start_y+key_height*1+key_buffer*1, key_width, key_height, "D", 0x44)
keys["F"] = key.new(start_x+key_width*5+key_buffer*5, start_y+key_height*1+key_buffer*1, key_width, key_height, "F", 0x46)
keys["SHIFT"] = key.new(start_x+key_width*0+key_buffer*0, start_y+key_height*2+key_buffer*2, key_width*2, key_height, "SHIFT", 0xA0)
keys["Z"] = key.new(start_x+key_width*2+key_buffer*2, start_y+key_height*2+key_buffer*2, key_width, key_height, "Z", 0x5A)
keys["X"] = key.new(start_x+key_width*3+key_buffer*3, start_y+key_height*2+key_buffer*2, key_width, key_height, "X", 0x58)
keys["C"] = key.new(start_x+key_width*4+key_buffer*4, start_y+key_height*2+key_buffer*2, key_width, key_height, "C", 0x43)
keys["CTRL"] = key.new(start_x+key_width*0+key_buffer*0, start_y+key_height*3+key_buffer*3, key_width*1.5, key_height, "CTRL", 0xA2)
keys["SPACE"] = key.new(start_x+key_width*2+key_buffer*2, start_y+key_height*3+key_buffer*3, key_width*4, key_height, "SPACE", 0x20)


log.debug("Q size: "..keys["Q"].size_x)
log.debug("SPACE size: "..keys["SPACE"].size_x)

local font = nil
	
local function draw_key_up(key)
	d2d.fill_rect(key.pos_x, key.pos_y, key.size_x, key.size_y, 0x60BBBBBB)
	d2d.text(font, key.text, key.pos_x, key.pos_y, 0xFF101010)
end

local function draw_key_down(key)
	d2d.fill_rect(key.pos_x, key.pos_y, key.size_x, key.size_y, 0x6022bd3c)
	d2d.text(font, key.text, key.pos_x, key.pos_y, 0xFF101010)
end

d2d.register(
	function()
		font = d2d.create_font("Tamoha", 30)
	end, 
	function()
		for k,v in pairs(keys) do
			if reframework:is_key_down(v.input) then
				draw_key_down(v)
			else
				draw_key_up(v)
			end
		end
	end
)