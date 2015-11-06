-- gen_cinit_enum.lua

-- Create the typedef enum for the numerous CURLOPT_ values
-- The CurlOptions.lua a table which maps the names of the options to 
-- their type and number.  
-- The current file will iterate over the name table, generating appropriate
-- enum entries for each, and generating a string value while doing it.
-- It will then execute that string to ensure that everything ok.
--
-- To use the generated data, just redirect to a file, and use that as
-- part of your ffi declarations.


local ffi = require("ffi")

local filename = arg[1] or "CurlMOptions"

local options = require(filename)

ffi.cdef[[
typedef enum {
	CURLOPTTYPE_LONG          = 0,
	CURLOPTTYPE_OBJECTPOINT   = 10000,
	CURLOPTTYPE_FUNCTIONPOINT = 20000,
	CURLOPTTYPE_OFF_T         = 30000
};
]]


local function CINIT(na,t,nu) 
	return string.format("\tCURLMOPT_%s = CURLOPTTYPE_%s+%d,", na, t, nu)
end

local tbl = {}
local function addenum(name, type, number)
	table.insert(tbl, CINIT(name, type, number));
end

table.insert(tbl, "local ffi = require('ffi')");
table.insert(tbl, "ffi.cdef[[\ntypedef enum {")

for k,v in pairs(options) do
	addenum(k, v[1], v[2]);
end

table.insert(tbl, "} CURLMoption;]]");

local tblstr = table.concat(tbl,'\n')
print(tblstr)
-- now get the definitions as a giant string
-- and execute it
local defs = loadstring(tblstr);
defs();
