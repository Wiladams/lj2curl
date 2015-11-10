-- CRLHttpRequest.lua
local ffi = require("ffi")
local curl = require("lj2curl")
local CRLEasyRequest = require("CRLEasyRequest")

local CRLHttpRequest = {}
setmetatable(CRLHttpRequest, {
	__call = function(self, ...)
		return self:new(...)
	end,

	__index = CRLEasyRequest;
})
local CRLHttpRequest_mt = {
	__index = CRLHttpRequest;
}


function CRLHttpRequest.init(self, handle, ...)
	local obj = {
		Handle = handle
	}
	setmetatable(obj, CRLHttpRequest_mt);

	if select('#',...) > 0 then
		if type(select(1,...)) == "string" then
			obj:url(select(1, ...))
		end
	end


	return obj;
end

function CRLHttpRequest.new(self, ...)
	local ctxt = curl.curl_easy_init()
	if ctxt == nil then
		return nil
	end

	ffi.gc(ctxt, curl.curl_easy_cleanup);

	return self:init(ctxt, ...);
end


function CRLHttpRequest.addHeader(self, name, value)
	-- Add header to existing list of headers
 	local headerstr = string.format("%s: %s", name, value)

 	self.Headers = curl.curl_slist_append(self.Headers, headerstr);
end

function CRLHttpRequest.send(self)
	-- set the headers all at once
	if self.Headers then
		self:setOption(curl.CURLOPT_HTTPHEADER, self.Headers)
	end

	return self:perform();
end

return CRLHttpRequest
