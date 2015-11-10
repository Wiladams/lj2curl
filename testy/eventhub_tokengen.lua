#!/usr/bin/env luajit

--eventhub_tokengen.lua
local scrypto = require("scrypto")

assert(#arg == 3, "must specify 3 arguments: url, keyname, keyvalue")

local url = arg[1]
local keyName = arg[2]
local keyValue = arg[3]

print (scrypto.createSasToken(url, keyName, keyValue))
