--scrypto.lua
--[[
	Herein there are just enough routines to do the typical amount of 
	crypto required to interact with a web service.

	base64
	urlencode
	sha256
	hmac

	There is one service specific routine: createSasToken
	Which is used by the Azure Service Bus to create tokens appropriate
	for that service.
--]]
local ffi = require "ffi"
local bit = require ("bit")
local tobit = bit.tobit;
local lshift = bit.lshift;
local rshift = bit.rshift;
local band = bit.band
local bor = bit.bor
local bnot = bit.bnot
local bxor = bit.bxor;
local rrotate = bit.ror



--[[
	BASE64 Encoding
--]]
local base64={}
local base64bytes = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

-- ' ' 0x20, '\t' 0x09, '\n' 0x0a, '\v' 0x0b, '\f' 0x0c, '\r' 0x0d
local function isspace(c)
	return c == 0x20 or c == 0x08 or c == 0x09 or
	  c == 0x0a or c == 0x0b or c == 0x0c or c == 0x0d
end

local function char64index(c)
	local pstart = ffi.cast("const char *", base64bytes);
	local p = pstart
	local offset = 0;

	while p[offset] ~= c do
		if p[offset] == 0 then
			--print("RETURNING NULL");
			return nil
		end
		offset = offset + 1
	end

	return offset
end



local function bencode(b, c1, c2, c3, n)
	local tuple = (c3+256*(c2+256*c1));
	local i;
	local s = {}

	for i=0, 3 do
		local offset = (tuple % 64)+1
		local c = base64bytes:sub(offset, offset)

		s[4-i] = c;
		tuple = rshift(tuple, 6)	-- tuple/64;
	end

	for i=n+2, 4 do
		s[i]='=';
	end

	local encoded = table.concat(s)

	table.insert(b,encoded);
end


function base64.encode(s, l)
	l = l or #s
	local ptr = ffi.cast("const uint8_t *", s);

	local b = {};
	local n = math.floor(l/3)
	for i=1,n do
		local c1 = ptr[(i-1)*3+0]
		local c2 = ptr[(i-1)*3+1]
		local c3 = ptr[(i-1)*3+2]
		bencode(b,c1,c2,c3,3);
	end

	-- Finish off the last few bytes
	local leftovers = l%3

	if leftovers == 1 then
		local c1 = ptr[(n*3)+0]
		bencode(b,c1,0,0,1);
	elseif leftovers == 2 then
		local c1 = ptr[(n*3)+0]
		local c2 = ptr[(n*3)+1]
		bencode(b,c1,c2,0,2);
	end

	return table.concat(b)
end


local function bdecode(b, c1, c2, c3, c4, n)
	local tuple = c4+64*(c3+64*(c2+64*c1));
	local s={};

	for i=1,n-1 do
		local shifter = 8 * (3-i)
		local abyte = band(rshift(tuple, shifter), 0xff)
		local achar = string.char(abyte);
		s[i] = achar
	end

	local decoded = table.concat(s)
	table.insert(b, decoded)
end


function base64.decode(s)
	local T_eq = string.byte('=')
	local l = #s;
	local b = {};
	local n=0;
	local t = ffi.new("char[4]",0);
	local offset = 0
	local ptr = ffi.cast("const char *", s);

	while (offset < l) do
		local c = ptr[offset];
		offset = offset + 1

		if c == 0 then
			return table.concat(b);
		elseif c == T_eq then
			if n ==  1 then
				bdecode(b,t[0],0,0,0,1);
			end
			if n == 2 then
				bdecode(b,t[0],t[1],0,0,2);
			end
			if n == 3 then
				bdecode(b,t[0],t[1],t[2],0,3);
			end

			-- If we've swallowed the '=', then
			-- we're at the end of the string, so return
			return table.concat(b)
		elseif isspace(c) then
			-- If whitespace, then do nothing
		else
			local p = char64index(c);
			if (p==nil) then
				return nil;
			end

			t[n]= p;
			n = n+1
			if (n==4) then
				bdecode(b,t[0],t[1],t[2],t[3],4);
				n=0;
			end
		end
	end

	-- if we've gotten to here, we've reached
	-- the end of the string, and there were
	-- no padding characters, so return decoded
	-- string in full
	return table.concat(b);
end

--[[
	SHA2  Digest

--]]
-- SHA-256 code in Lua 5.2; based on the pseudo-code from
-- Wikipedia (http://en.wikipedia.org/wiki/SHA-2)

local string, setmetatable, assert = string, setmetatable, assert


-- Initialize table of round constants
-- (first 32 bits of the fractional parts of the cube roots of the first
-- 64 primes 2..311):
local k = {
   0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
   0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
   0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
   0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
   0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
   0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
   0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
   0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
   0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
   0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
   0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
   0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
   0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
   0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
   0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
   0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
   }

-- convert from a string of hex values to a 
-- binary string
function hexa2str(str)
    return (str:gsub('..', function (cc)
        return string.char(tonumber(cc, 16))
    end))
end


-- transform a string of bytes in a string of hexadecimal digits
local function str2hexa (s)
	local h = string.gsub(s, ".",
		function(c) return string.format("%02x", string.byte(c)) end)
  return h
end

-- transform number 'l' in a big-endian sequence of 'n' bytes
-- (coded as a string)
local function num2s (l, n)
	local s = ""
	for i = 1, n do
		local rem = l % 256
		s = string.char(rem) .. s
		l = (l - rem) / 256
	end
	return s
end

-- transform the big-endian sequence of four bytes starting at
-- index 'i' in 's' into a number
local function s232num (s, i)
	local n = 0
	for i = i, i + 3 do
		n = n*256 + string.byte(s, i)
	end
	return n
end

-- append the bit '1' to the message
-- append k bits '0', where k is the minimum number >= 0 such that the
-- resulting message length (in bits) is congruent to 448 (mod 512)
-- append length of message (before pre-processing), in bits, as 64-bit
-- big-endian integer
local function preproc (msg, len)
	local extra = 64 - ((len + 1 + 8) % 64)
	len = num2s(8 * len, 8)    -- original len in bits, coded
	msg = msg .. "\128" .. string.rep("\0", extra) .. len
	assert(#msg % 64 == 0)
	return msg
end

local function initH224 (H)
  -- (second 32 bits of the fractional parts of the square roots of the
  -- 9th through 16th primes 23..53)
  H[1] = 0xc1059ed8
  H[2] = 0x367cd507
  H[3] = 0x3070dd17
  H[4] = 0xf70e5939
  H[5] = 0xffc00b31
  H[6] = 0x68581511
  H[7] = 0x64f98fa7
  H[8] = 0xbefa4fa4
	return H
end

local function initH256 (H)
  -- (first 32 bits of the fractional parts of the square roots of the
  -- first 8 primes 2..19):
  H[1] = 0x6a09e667
  H[2] = 0xbb67ae85
  H[3] = 0x3c6ef372
  H[4] = 0xa54ff53a
  H[5] = 0x510e527f
  H[6] = 0x9b05688c
  H[7] = 0x1f83d9ab
  H[8] = 0x5be0cd19
	return H
end

local function digestblock (msg, i, H)
    -- break chunk into sixteen 32-bit big-endian words w[1..16]
	local w = {}
    for j = 1, 16 do
		w[j] = s232num(msg, i + (j - 1)*4)
	end

	-- Extend the sixteen 32-bit words into sixty-four 32-bit words:
    for j = 17, 64 do
		local s0 = bxor(rrotate(w[j - 15], 7), rrotate(w[j - 15], 18), rshift(w[j - 15], 3))
		local s1 = bxor(rrotate(w[j - 2], 17), rrotate(w[j - 2], 19), rshift(w[j - 2], 10))
		w[j] = w[j - 16] + s0 + w[j - 7] + s1
	end

	-- Initialize hash value for this chunk:
	local a, b, c, d, e, f, g, h =
	H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8]    -- Main loop:
    for i = 1, 64 do
      local s0 = bxor(rrotate(a, 2), rrotate(a, 13), rrotate(a, 22))
      local maj = bxor(band(a, b), band(a, c), band(b, c))
      local t2 = s0 + maj
      local s1 = bxor(rrotate(e, 6), rrotate(e, 11), rrotate(e, 25))
      local ch = bxor (band(e, f), band(bnot(e), g))
      local t1 = h + s1 + ch + k[i] + w[i]
	  h = g
	  g = f
	  f = e
      e = d + t1
	  d = c
	  c = b
	  b = a
	  a = t1 + t2
	end

	-- Add (mod 2^32) this chunk's hash to result so far:
    H[1] = tobit(H[1] + a)
	H[2] = tobit(H[2] + b)
	H[3] = tobit(H[3] + c)
    H[4] = tobit(H[4] + d)
	H[5] = tobit(H[5] + e)
	H[6] = tobit(H[6] + f)
    H[7] = tobit(H[7] + g)
	H[8] = tobit(H[8] + h)
end

local function finalresult224 (H)  -- Produce the final hash value (big-endian):
	return str2hexa(num2s(H[1], 4)..num2s(H[2], 4)..num2s(H[3], 4)..num2s(H[4], 4)..
             num2s(H[5], 4)..num2s(H[6], 4)..num2s(H[7], 4))
end

local function finalresult256 (H)  -- Produce the final hash value (big-endian):
	return str2hexa(num2s(H[1], 4)..num2s(H[2], 4)..num2s(H[3], 4)..num2s(H[4], 4)..
             num2s(H[5], 4)..num2s(H[6], 4)..num2s(H[7], 4)..num2s(H[8], 4))
end

----------------------------------------------------------------------
local function sha224 (msg)
	msg = preproc(msg, #msg)
	local H = initH224({})

	-- Process the message in successive 512-bit (64 bytes) chunks:
	for i = 1, #msg, 64 do
		digestblock(msg, i, H)
	end

	return finalresult224(H)
end

local function sha256 (msg)
	msg = preproc(msg, #msg)
	local H = initH256({})
	-- Process the message in successive 512-bit (64 bytes) chunks:
	for i = 1, #msg, 64 do
		digestblock(msg, i, H)
	end

	return finalresult256(H)
end

--[[
--HMAC implementation
--http://tools.ietf.org/html/rfc2104
--http://en.wikipedia.org/wiki/HMAC
--]]

local function string_xor(s1, s2)
        assert(#s1 == #s2, 'strings must be of equal length')
        local buf = ffi.new('uint8_t[?]', #s1)
        for i=1,#s1 do
                buf[i-1] = bxor(s1:byte(i,i), s2:byte(i,i))
        end
        return ffi.string(buf, #s1)
end

--any hash function works, md5, sha256, etc.
--blocksize is that of the underlying hash function (64 for MD5 and SHA-256, 128 for SHA-384 and SHA-512)
local function compute(key, message, hash, blocksize, opad, ipad)
	if #key > blocksize then
		key = hash(key) --keys longer than blocksize are shortened
	end
	
	key = key .. string.rep('\0', blocksize - #key) --keys shorter than blocksize are zero-padded
	opad = opad or string_xor(key, string.rep(string.char(0x5c), blocksize))
	ipad = ipad or string_xor(key, string.rep(string.char(0x36), blocksize))
    
    return hash(opad .. hash(ipad .. message)), opad, ipad --opad and ipad can be cached for the same key
end

local function hmac_new(hash, blocksize)
	return function(message, key)
		return (compute(key, message, hash, blocksize))
	end
end

local function binsha256(msg)
	return hexa2str(sha256(msg))
end

local	hmac_sha256 = hmac_new(binsha256, 64);



--[[
	URL Encoding
--]]
function urlencode(str)
   if (str) then
      str = string.gsub (str, "\n", "\r\n")
      str = string.gsub (str, "([^%w ])",
         function (c) return string.format ("%%%02X", string.byte(c)) end)
      str = string.gsub (str, " ", "+")
   end
   return str    
end

--[[
	uri - The uri you are connecting to
	key_name - name of the Sas key that is being used
	key - actual Sas key

	Reference
	http://hypernephelist.com/2014/09/16/sending-data-to-azure-event-hubs-from-nodejs.html
--]]
local function createSasToken(uri, key_name, key, expiry)
    -- If no expiration is specified, then use
    -- one hour from current time (local timezone)
    local secspermin = 60
    local minsperhour = 60
    expiry = expiry or os.time() + 24 * minsperhour * secspermin ;

    local string_to_sign = urlencode(uri) .. '\n' .. expiry;
print("string_to_sign: ", string_to_sign)

    local hmac = hmac_sha256(string_to_sign, key);
print("hmac: ", #hmac, str2hexa(hmac))

 	local signature = base64.encode(hmac);
 print("signature: ", signature)

    local token = 'SharedAccessSignature sr=' .. urlencode(uri) .. '&sig=' .. urlencode(signature) .. '&se=' .. expiry .. '&skn=' .. key_name;

    return token;
end



--[[
	EXPORTS
--]]
local exports = {
	base64 = base64,
	sha224 = sha224,
	sha256 = sha256,

	hmac_sha256 = hmac_sha256,

	urlencode = urlencode,

	createSasToken = createSasToken,
}

return exports
