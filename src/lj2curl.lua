--lj2curl.lua
local ffi = require("ffi")
local bit = require("bit")
local lshift, rshift, bor, band = bit.lshift, bit.rshift, bit.bor, bit.band

local Lib_curl = require("curl_ffi")

local function Lib_curl_cleanup(lib)
	print("Lib_curl_cleanup()")
    Lib_curl.curl_global_cleanup();
end


if Lib_curl then
    -- global_init(); must be called once per application lifetime
    Lib_curl.curl_global_init();

    ffi.gc(Lib_curl, Lib_curl_cleanup);
else
	return false;
end


C = {
	LIBCURL_COPYRIGHT ="1996 - 2015 Daniel Stenberg, <daniel@haxx.se>.";

	LIBCURL_VERSION ="7.46.0-DEV";	-- the current binding is built on this version


	LIBCURL_VERSION_MAJOR = 7;
	LIBCURL_VERSION_MINOR = 46;
	LIBCURL_VERSION_PATCH = 0;


	LIBCURL_VERSION_NUM = 0x072E00;
}

local function CURL_VERSION_BITS(x,y,z) 
	return bor(lshift(x,16),lshift(y,8),z)
end

local function CURL_AT_LEAST_VERSION(x,y,z)
  return C.LIBCURL_VERSION_NUM >= CURL_VERSION_BITS(x, y, z)
end

local exports = {}

return exports;
