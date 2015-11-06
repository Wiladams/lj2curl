--test_curl.lua
package.path = package.path..";../src/?.lua"
local ffi = require("ffi")

local curl = require("lj2curl")

local str = curl.curl_version();
assert(str)


print("Version: ", ffi.string(str))
