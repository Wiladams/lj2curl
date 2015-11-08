--test_curloptions.lua
package.path = package.path..";../src/?.lua"

local curl = require("lj2curl")
local CurlOptions = require("CurlOptions")
local fun = require("fun")

local function printit(...)
	print(select('#',...), ...)
end

local function isCode(code)
	code = code - curl.
	local function predicate(key, value)
		if value[2] == code then
			fun.each(print, value)
			return true;
		end

		return false;
	end

	return predicate
end

local whatCode = curl.READFUNCTION;
fun.each(print, fun.filter(isCode(whatCode), CurlOptions))

--fun.each(printit, CurlOptions)
