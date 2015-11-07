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
	local flags = 0;
    -- global_init(); must be called once per application lifetime
    Lib_curl.curl_global_init(flags);

    --ffi.gc(Lib_curl, Lib_curl_cleanup);
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

setmetatable(exports, {
	__index = function(self, key)
		local value = nil;
		local success = false;

		-- try looking in the library for a function
		success, value = pcall(function() return Lib_curl[key] end)
		if success then
			rawset(self, key, value);
			return value;
		end

		-- try looking in the ffi.C namespace, for constants
		-- and enums
		success, value = pcall(function() return ffi.C[key] end)
		--print("looking for constant/enum: ", key, success, value)
		if success then
			rawset(self, key, value);
			return value;
		end

		-- Or maybe it's a type
		success, value = pcall(function() return ffi.typeof(key) end)
		if success then
			rawset(self, key, value);
			return value;
		end

		return nil;
	end,
})


return exports;
