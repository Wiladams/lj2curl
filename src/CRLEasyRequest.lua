--[[
--]]

local ffi = require("ffi")
local bit = require("bit")
local band, bor, lshift, rshift = bit.band, bit.bor, bit.lshift, bit.rshift

local curl = require("lj2curl")

local CRLEasyRequest = {}
setmetatable(CRLEasyRequest, {
	__call = function(self, ...)
		return self:new(...);
	end,
})

local CRLEasyRequest_mt = {
	__index = CRLEasyRequest;
}

function CRLEasyRequest.init(self, handle, ...)
	local obj = {
		Handle = handle;
	}
	setmetatable(obj, CRLEasyRequest_mt)

	if select('#',...) > 0 then
		if type(select(1,...)) == "string" then
			obj:url(select(1, ...))
		end
	end

	return obj;
end

function CRLEasyRequest.new(self, ...)
	local ctxt = curl.curl_easy_init()
	if ctxt == nil then
		return nil
	end

	ffi.gc(ctxt, curl.curl_easy_cleanup);

	return self:init(ctxt, ...);
end

ffi.cdef[[
typedef union {
	long 				longValue;
	double				doubleValue;
	char * 				strValue;
	struct curl_slist * listValue;
} curl_info_union_t;
]]

--[[
static const int CURLINFO_STRING   = 0x100000;
static const int CURLINFO_LONG     = 0x200000;
static const int CURLINFO_DOUBLE   = 0x300000;
static const int CURLINFO_SLIST    = 0x400000;
static const int CURLINFO_SOCKET   = 0x500000;
]]

function CRLEasyRequest.getInfo(self, info)

	local value = ffi.new("curl_info_union_t")
	local res = curl.curl_easy_getinfo(self.Handle, info, value);
	if curl.CURLE_OK ~= res then
		return false, ffi.string(curl.curl_easy_strerror(res));
	end

	local infoType = band(curl.CURLINFO_TYPEMASK, info)

--print(string.format("\ninfoType: 0x%x", infoType))
	if infoType == curl.CURLINFO_STRING then
		return ffi.string(value.strValue)
	elseif infoType == curl.CURLINFO_LONG then
		return value.longValue
	elseif infoType == curl.CURLINFO_DOUBLE then
		return tonumber(value.doubleValue);
	end
	
	return value;
end

function CRLEasyRequest.perform(self)
	local res = curl.curl_easy_perform(self.Handle);
	if res ~= curl.CURLE_OK then
		return false, ffi.string(curl.curl_easy_strerror(res));
	end

	return self;
end

function CRLEasyRequest.reset(self)
	curl.curl_easy_reset(self.Handle);

	return self;
end

function CRLEasyRequest.receive(self, buffer, buflen)
	local bytesTransferred = ffi.new("size_t[1]")
	local res = curl.curl_easy_recv(self.Handle, buffer, buflen, bytesTransferred);

	if res ~= curl.CURLE_OK then
		return false, res, ffi.string(curl.curl_easy_strerror(res))
	end

	bytesTransferred = bytesTransferred[0];

	return bytesTransferred; 
end

function CRLEasyRequest.send(self, buffer, buflen)
	local bytesTransferred = ffi.new("size_t[1]")
	local res = curl.curl_easy_send(self.Handle, buffer, buflen, bytesTransferred);

	if res ~= curl.CURLE_OK then
		return false, res, ffi.string(curl.curl_easy_strerror(res))
	end

	bytesTransferred = bytesTransferred[0];

	return bytesTransferred; 
end

function CRLEasyRequest.setOption(self, opt, param)
	local res = curl.curl_easy_setopt(self.Handle, opt, param);
	
	if res ~= curl.CURLE_OK then
		return false, res, ffi.string(curl.curl_easy_strerror(res));
	end

	return self;
end

-- Some handy options
function CRLEasyRequest.url(self, strurl)
	return self:setOption(curl.CURLOPT_URL, ffi.cast("const char *", strurl))
end

return CRLEasyRequest
