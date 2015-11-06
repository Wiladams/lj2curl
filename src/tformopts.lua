function startswith(s, prefix)
	return string.find(s, prefix, 1, true) == 1
end

--CINIT(PROXYHEADER, OBJECTPOINT, 228),


local function writeClean()
	for line in io.lines("CurlOpt.lua") do
		if startswith(line, "CINIT") then
			name, tp, num = line:match("CINIT%((%g+),%s*(%g+),%s*(%d+)")
			print(string.format("\t%-25s = {'%s', %s},", name, tp, num))
		end
	end
end


local function writeGarbage()
	for line in io.lines("CurlOpt.lua") do
		if not startswith(line, "CINIT") then
			print(line)
		end
	end
end

writeClean()
--writeGarbage()