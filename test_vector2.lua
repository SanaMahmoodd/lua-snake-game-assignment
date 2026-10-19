local Vector2 = require("vector2")

local a = Vector2:new(10, 10)
local b = Vector2:new(1, 0)

local result = a + b

print("Vector Addition:", tostring(result))

local c = Vector2:new(10, 10)

print("Vector Equality:", a == c)

print("Vector String:", tostring(a))