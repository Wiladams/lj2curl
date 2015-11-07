#!/usr/bin/env luajit

package.path = package.path..";../src/?.lua"

-- As the CRLEasyRequest defaults to a basic HTTP GET in the case of http
-- This is the easiest way to perform a GET, and have the output 
-- print on stdout
if not arg[1] then return end

require("CRLEasyRequest")(arg[1]):perform();
