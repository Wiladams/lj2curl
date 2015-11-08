#!/usr/bin/env luajit

package.path = package.path..";../src/?.lua"

-- As the CRLEasyRequest defaults to a basic HTTP GET in the case of http
-- This is the easiest way to perform a GET, and have the output 
-- print on stdout
local ffi = require("ffi")
local curl = require("lj2curl")
local ezreq = require("CRLEasyRequest")

local function getit()

if not arg[1] then return end


local conn = ezreq(arg[1])
assert(conn)

local res, err, errstr = conn:perform()

if not res then
	print("perform error(): ", err, errstr)
	return false, err
end

-- ask for the content-type */ 
local res, err, errstr = conn:getInfo(curl.CURLINFO_CONTENT_TYPE);
 
if res then
    print("\ngeInfo(), res: ", res)
    print(string.format("We received Content-Type: %s\n", ffi.string(res.strValue)));
else
	print("getInfo(), err: ", err, errstr)
end

end

getit()
