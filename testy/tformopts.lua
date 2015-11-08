--[[
	This file facilitates turning the numerous CINIT() macro
	calls found int he curl.h header into a table of name /values.

	A typical call within the header is this:

		CINIT(PROXYHEADER, OBJECTPOINT, 228),

	What is generated would be:

		PROXYHEADER               = {'OBJECTPOINT', 228},

	Which the CINIT.lua utility will ultimately be turned into:
		CURLOPT_PROXYHEADER = CURLOPTTYPE_OBJECTPOINT+228,


--]]

local ffi = require("ffi")

ffi.cdef[[
typedef enum {
	CURLOPTTYPE_LONG          = 0,
	CURLOPTTYPE_OBJECTPOINT   = 10000,
	CURLOPTTYPE_FUNCTIONPOINT = 20000,
	CURLOPTTYPE_OFF_T         = 30000
};
]]

function startswith(s, prefix)
	return string.find(s, prefix, 1, true) == 1
end

local function writeLookupTable(filename)
	for line in io.lines(filename) do
		if startswith(line, "CINIT") then
			name, tp, num = line:match("CINIT%((%g+),%s*(%g+),%s*(%d+)")

			local typename = "CURLOPTTYPE_"..tp;
			local basetypevalue = tonumber(ffi.C[typename]);


			print(string.format("\t[%d] = {'%s', '%s'},", basetypevalue +tonumber(num), tp, name))
			--print(string.format("\t%-25s = {'%s', %s},", name, tp, num))
		end
	end
end


local function writeClean(filename)
	for line in io.lines(filename) do
		if startswith(line, "CINIT") then
			name, tp, num = line:match("CINIT%((%g+),%s*(%g+),%s*(%d+)")
			print(string.format("\t%-25s = {'%s', %s},", name, tp, num))
		end
	end
end


local function writeGarbage(filename)
	for line in io.lines(filename) do
		if not startswith(line, "CINIT") then
			print(line)
		end
	end
end

local filename = arg[1] or "CurlOpt.lua"
--writeClean(filename)
--writeGarbage(filename)
writeLookupTable(filename);