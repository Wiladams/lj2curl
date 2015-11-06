--CINIT.lua
-- test out this macro expansion into an enum
-- The options are in the CurlOptions.lua file
-- This file will read those values in, and construct
-- an enum definition for them at runtime

local ffi = require("ffi")
local CurlOptions = require("CurlOptions")

ffi.cdef[[
typedef enum {
CURLOPTTYPE_LONG          = 0,
CURLOPTTYPE_OBJECTPOINT   = 10000,
CURLOPTTYPE_FUNCTIONPOINT = 20000,
CURLOPTTYPE_OFF_T         = 30000
};
]]


local function CINIT(na,t,nu) 
	return string.format("CURLOPT_%s = CURLOPTTYPE_%s+%d,", na, t, nu)
end

local tbl = {}
local function addenum(name, type, number)
	table.insert(tbl, CINIT(name, type, number));
end

table.insert(tbl, "local ffi = require('ffi')");
table.insert(tbl, "ffi.cdef[[typedef enum {")

for k,v in pairs(CurlOptions) do
	addenum(k, v[1], v[2]);
end

table.insert(tbl, "} CURLoption;]]");

local tblstr = table.concat(tbl,'\n')
print(tblstr)
-- now get the definitions as a giant string
-- and execute it
local defs = loadstring(tblstr);
defs();

print("CURLOPT_WRITEDATA: ", ffi.C.CURLOPT_WRITEDATA)
