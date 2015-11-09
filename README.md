# lj2curl
LuaJIT binding to libcurl

cURL is a fairly stable well known tool for doing quick and dirty network tasks, such as downloading 
files from http servers, ftp servers, and the like.  It is fairly flexible in that there are a number
of parameters that can be set to deal with the specifics of a protocol, and shape the output into 
various forms.

This binding brings cURL into the LuaJIT work through a binding to libcurl, which is the heart of the 
cURL utility.  By providing this binding, applications can be written without having to call out to 
a command line shell to execute the cURL utility.  This also gives you programmatic support to all the
various features and parameters that libcurl has to offer, from the nice LuaJIT environment.

Here is an example of calling one of the standard functions within the libcurl library

```lua
local ffi = require("ffi")
local curl = require("lj2curl")

local str = curl.curl_version();
assert(str)

print("Version: ", ffi.string(str))
```

In this particular case, it's showing that you are free to call all the library functions simply by
referring to them through the 'curl' interface.  All functions, constants, enums, and types are 
available through this simple mechanism.  If you use the interface in this way, you are responsible
for dealing with memory allocations, error checking, and the like, just as if you were writing
code in 'C'.

Here is anoter very simple example of downloading an html page and having the output written to stdout.  In this case, the 'CRLEasyRequest' object interface is bing used:

```lua
require("CRLEasyRequest")("https://www.bing.com"):perform();
```

That's it.  Just one line of code, and you can download a web page.  Of course, this is using
all the default options, so it's not necessarily going to be the most performant, nor will it 
show all the details you might like (http headers), but, it will get the job done.

A more involved example, where we want to capture the HTTP headers coming back, separate from the body,
and display some extra info, such as the source and destination IP addresses, could look like this:

```lua
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
-- it has been left black here for brevity
local infoNames = {}

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
```
