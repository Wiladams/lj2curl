local scrypto = require("scrypto")

local function main(params)
	local url = string.format("https://%s.servicebus.windows.net/%s/messages",
		params.sbusNamespace,
		params.evhubName);

	local token = scrypto.createSasToken(url, params.keyName, params.key)

	print(token)
end

local params = {
	sbusNamespace = "eventhub-ns",
	evhubName = "bighub",
	keyName = "senderkey",
	key = "abcdefghijklmnop"
}

main(params)