#!/usr/bin/env luajit

package.path = package.path..";../src/?.lua"

-- As the CRLEasyRequest defaults to a basic HTTP GET in the case of http
-- This is the easiest way to perform a GET, and have the output 
-- print on stdout
local ffi = require("ffi")
local curl = require("lj2curl")
local ezreq = require("CRLEasyRequest")
local fun = require("fun")

local long = ffi.typeof("long")

-- This is a simple lookup table to go from the CURLINFO_ 
-- constants to strings
local infoNames = {
	[curl.CURLINFO_NONE] = "NONE", 						-- /* first, never use this */
	[curl.CURLINFO_EFFECTIVE_URL] 	 = "EFFECTIVE_URL",    	-- = CURLINFO_STRING + 1,
	[curl.CURLINFO_RESPONSE_CODE]    = "RESPONSE_CODE",								-- CURLINFO_LONG   + 2,
	[curl.CURLINFO_TOTAL_TIME]       = "TOTAL_TIME",								-- CURLINFO_DOUBLE + 3,
	[curl.CURLINFO_NAMELOOKUP_TIME]  = "NAMELOOKUP_TIME",								-- CURLINFO_DOUBLE + 4,
	[curl.CURLINFO_CONNECT_TIME]     = "CONNECT_TIME",								-- CURLINFO_DOUBLE + 5,
	[curl.CURLINFO_PRETRANSFER_TIME] = "PRETRANSFER_TIME",								-- CURLINFO_DOUBLE + 6,
	[curl.CURLINFO_SIZE_UPLOAD]      = "SIZE_UPLOAD",								-- CURLINFO_DOUBLE + 7,
	[curl.CURLINFO_SIZE_DOWNLOAD]    = "SIZE_DOWNLOAD",								-- CURLINFO_DOUBLE + 8,
	[curl.CURLINFO_SPEED_DOWNLOAD]   = "SPEED_DOWNLOAD",								-- CURLINFO_DOUBLE + 9,
	[curl.CURLINFO_SPEED_UPLOAD]     = "SPEED_UPLOAD",								-- CURLINFO_DOUBLE + 10,
	[curl.CURLINFO_HEADER_SIZE]      = "HEADER_SIZE",								-- CURLINFO_LONG   + 11,
	[curl.CURLINFO_REQUEST_SIZE]     = "REQUEST_SIZE",								-- CURLINFO_LONG   + 12,
	[curl.CURLINFO_SSL_VERIFYRESULT] = "SSL_VERIFYRESULT",								-- CURLINFO_LONG   + 13,
	[curl.CURLINFO_FILETIME]         = "FILETIME",								-- CURLINFO_LONG   + 14,
	[curl.CURLINFO_CONTENT_LENGTH_DOWNLOAD]   = "CONTENT_LENGTH_DOWNLOAD",						-- CURLINFO_DOUBLE + 15,
	[curl.CURLINFO_CONTENT_LENGTH_UPLOAD]     = "CONTENT_LENGTH_UPLOAD", --CURLINFO_DOUBLE + 16,
	[curl.CURLINFO_STARTTRANSFER_TIME] = "STARTTRANSFER_TIME", --CURLINFO_DOUBLE + 17,
	[curl.CURLINFO_CONTENT_TYPE]     = "CONTENT_TYPE", --CURLINFO_STRING + 18,
	[curl.CURLINFO_REDIRECT_TIME]    = "REDIRECT_TIME", --CURLINFO_DOUBLE + 19,
	[curl.CURLINFO_REDIRECT_COUNT]   = "REDIRECT_COUNT", --CURLINFO_LONG   + 20,
	[curl.CURLINFO_PRIVATE]          = "PRIVATE", --CURLINFO_STRING + 21,
	[curl.CURLINFO_HTTP_CONNECTCODE] = "HTTP_CONNECTCODE", --CURLINFO_LONG   + 22,
	[curl.CURLINFO_HTTPAUTH_AVAIL]   = "HTTPAUTH_AVAIL", --CURLINFO_LONG   + 23,
	[curl.CURLINFO_PROXYAUTH_AVAIL]  = "PROXYAUTH_AVAIL", --CURLINFO_LONG   + 24,
	[curl.CURLINFO_OS_ERRNO]         = "OS_ERRNO", --CURLINFO_LONG   + 25,
	[curl.CURLINFO_NUM_CONNECTS]     = "NUM_CONNECTS", --CURLINFO_LONG   + 26,
	[curl.CURLINFO_SSL_ENGINES]      = "SSL_ENGINES", --CURLINFO_SLIST  + 27,
	[curl.CURLINFO_COOKIELIST]       = "COOKIELIST", --CURLINFO_SLIST  + 28,
	[curl.CURLINFO_LASTSOCKET]       = "LASTSOCKET", --CURLINFO_LONG   + 29,
	[curl.CURLINFO_FTP_ENTRY_PATH]   = "FTP_ENTRY_PATH", --CURLINFO_STRING + 30,
	[curl.CURLINFO_REDIRECT_URL]     = "REDIRECT_URL", --CURLINFO_STRING + 31,
	[curl.CURLINFO_PRIMARY_IP]       = "PRIMARY_IP", --CURLINFO_STRING + 32,
	[curl.CURLINFO_APPCONNECT_TIME]  = "APPCONNECT_TIME", --CURLINFO_DOUBLE + 33,
	[curl.CURLINFO_CERTINFO]         = "CERTINFO", --CURLINFO_SLIST  + 34,
	[curl.CURLINFO_CONDITION_UNMET]  = "CONDITION_UNMET", --CURLINFO_LONG   + 35,
	[curl.CURLINFO_RTSP_SESSION_ID]  = "RTSP_SESSION_ID", --CURLINFO_STRING + 36,
	[curl.CURLINFO_RTSP_CLIENT_CSEQ] = "RTSP_CLIENT_CSEQ", --CURLINFO_LONG   + 37,
	[curl.CURLINFO_RTSP_SERVER_CSEQ] = "RTSP_SERVER_CSEQ", --CURLINFO_LONG   + 38,
	[curl.CURLINFO_RTSP_CSEQ_RECV]   = "RTSP_CSEQ_RECV", --CURLINFO_LONG   + 39,
	[curl.CURLINFO_PRIMARY_PORT]     = "PRIMARY_PORT", --CURLINFO_LONG   + 40,
	[curl.CURLINFO_LOCAL_IP]         = "LOCAL_IP", --CURLINFO_STRING + 41,
	[curl.CURLINFO_LOCAL_PORT]       = "LOCAL_PORT", --CURLINFO_LONG   + 42,
	[curl.CURLINFO_TLS_SESSION]      = "TLS_SESSION", --CURLINFO_SLIST  + 43,
	[curl.CURLINFO_ACTIVESOCKET]     = "ACTIVESOCKET", --CURLINFO_SOCKET + 44,
}

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
jit.off(receiveHeaders)


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
local function getit(url)

	local conn = ezreq(arg[1])
	assert(conn)
	--conn:setOption(curl.CURLOPT_VERBOSE, long(1))
	conn:setOption(curl.CURLOPT_HEADER, long(1))
	conn:setOption(curl.CURLOPT_HEADERFUNCTION, ffi.cast("header_callback", receiveHeaders))
	conn:setOption(curl.CURLOPT_WRITEFUNCTION, ffi.cast("write_callback", receiveBody))
	-- Execute the request
	local res, err, errstr = conn:perform()

	if not res then
		print("perform error(): ", err, errstr)
		return false, err
	end


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

end

assert(arg[1])
getit(arg[1])
