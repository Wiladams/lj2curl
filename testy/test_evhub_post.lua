#!/usr/bin/env luajit

package.path = package.path..";../src/?.lua"

-- As the CRLEasyRequest defaults to a basic HTTP GET in the case of http
-- This is the easiest way to perform a GET, and have the output 
-- print on stdout
local ffi = require("ffi")
local curl = require("lj2curl")
local ezreq = require("CRLEasyRequest")
local fun = require("fun")
local infoName = require("curlInfo")
local CRLHttpRequest = require("CRLHttpRequest")
local scrypto = require("scrypto")

local long = ffi.typeof("long")



ffi.cdef[[
typedef size_t (* header_callback)(char *buffer,   size_t size,   size_t nitems,   void *userdata); 
typedef size_t (* write_callback)(char *buffer,   size_t size,   size_t nitems,   void *userdata); 
]]

local headers = {}
local function receiveHeaders(buffer, size, nitems, userdata)
	print("receiveHeaders: ", buffer, size, nitems)
	table.insert(headers, ffi.string(buffer, size*nitems))

	return nitems;
end
jit.off(receiveHeaders)

local body = {}
local function receiveBody(buffer, size, nitems, userdata)
	print("receiveBody: ", buffer, size, nitems)
	table.insert(body, ffi.string(buffer, size*nitems))

	return nitems;
end
jit.off(receiveBody)


-- An iterator over the info fields
local function iter_infoFields(conn, fields)
	local function gen_info(fields, idx)
		if idx > #fields then
			return nil;
		end

		return idx+1, infoNames[fields[idx]], conn:getInfo(fields[idx])
	end

	return gen_info, fields, 1
end

-- Retrieve a particular URL
local function main(params)
	local url = string.format("https://%s.servicebus.windows.net/%s/messages",	params.sbusNamespace, params.evhubName);
print("URL: ", url)
	
	local req = CRLHttpRequest(url)
	assert(req)

	-- set some specific options
	req:setOption(curl.CURLOPT_VERBOSE, long(1))
	req:setOption(curl.CURLOPT_POST, long(1))
	--req:setOption(curl.CURLOPT_HEADER, long(1))
	--req:setOption(curl.CURLOPT_HEADERFUNCTION, ffi.cast("header_callback", receiveHeaders))
	--req:setOption(curl.CURLOPT_WRITEFUNCTION, ffi.cast("write_callback", receiveBody))


	-- set some general headers
	req:addHeader("Authorization", params.sasToken)
	req:addHeader("Content-Type", 'application/atom+xml;type=entry;charset=utf-8')
	--req:addHeader("Transfer-Encoding", "chunked")
	--req:addHeader("Expect", "")

	local ehubbody = '{"phrase": "This is my body you eat"}'
	req:setOption(curl.CURLOPT_POSTFIELDS, ffi.cast("const char *", ehubbody));
	req:setOption(curl.CURLOPT_POSTFIELDSIZE, long(#ehubbody)); 

	-- Execute the request
	local res, err, errstr = req:send()

	if not res then
		print("perform error(): ", err, errstr)
		return false, err
	end

--[[
	local headstr = table.concat(headers);
	print("==== HEADERS ====")
	print(headstr)

	local bodystr = table.concat(body);
	print("==== BODY ====")
	print(bodystr)

	print();

	-- print various fields
	local infoFields = {
		curl.CURLINFO_EFFECTIVE_URL,
		curl.CURLINFO_RESPONSE_CODE,
		curl.CURLINFO_CONTENT_TYPE,
		curl.CURLINFO_CONTENT_LENGTH_DOWNLOAD,
		curl.CURLINFO_PRIMARY_IP,
		curl.CURLINFO_PRIMARY_PORT,
		curl.CURLINFO_LOCAL_IP,
		curl.CURLINFO_LOCAL_PORT,
	}
	print("==== INFO ====")
	fun.each(print, iter_infoFields(conn, infoFields))
--]]
end

local sasToken = arg[1]
local params = {
	sbusNamespace = "azl-evhub2",
	evhubName = "testhub1",
	sasToken = sasToken,
}
main(params)
