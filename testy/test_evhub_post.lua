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

local function postEntry(url, body, sasToken)
	local req = CRLHttpRequest(url)
	assert(req)

	-- set some specific options
	--req:setOption(curl.CURLOPT_VERBOSE, long(1))
	req:setOption(curl.CURLOPT_POST, long(1))

	-- set some general headers
	req:addHeader("Authorization", sasToken)
	req:addHeader("Content-Type", 'application/atom+xml;type=entry;charset=utf-8')

	req:setOption(curl.CURLOPT_POSTFIELDS, ffi.cast("const char *", body));
	req:setOption(curl.CURLOPT_POSTFIELDSIZE, long(#body)); 

	-- Execute the request
	local res, err, errstr = req:send()

	if not res then
		print("perform error(): ", err, errstr)
		return false, err
	end

	return true;
end

local function main(params)
	local url = string.format("https://%s.servicebus.windows.net/%s/messages",	params.sbusNamespace, params.evhubName);
--print("URL: ", url)
	
	for count=1,params.iterations or 10 do
		print("sending: ", count)
		local body = string.format('{"phrase": "This is my count: %d"}', count)
		if not postEntry(url, body, params.sasToken) then
			break
		end
	end

end

local sasToken = arg[1] or "[SharedAccessSignature goes here]"

local params = {}

main(params)
