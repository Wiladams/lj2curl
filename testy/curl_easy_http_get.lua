--curl_easy_http_get.lua
package.path = package.path..";../src/?.lua"

-- As the CRLEasyRequest defaults to a basic HTTP GET in the case of http
-- This is the easiest way to perform a GET, and have the output 
-- print on stdout
local url = arg[1] or "http://www.bing.com"
require("CRLEasyRequest")(url):perform();
