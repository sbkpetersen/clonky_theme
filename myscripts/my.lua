print ("init lua-script")

function init_cpus()
	local file = io.popen("grep -c processor /proc/cpuinfo")
	local numcpus = file:read("*n")
	file:close()
	listcpus = ""
	for i = 1,numcpus,4
	do
		listcpus = listcpus..   "${color1}${font}CPU"..tostring(i)..":$color ${goto 95}${cpu cpu"..tostring(i).."}% "..
					"${color1}CPU"..tostring(i+1)..":$color ${goto 200}${cpu cpu"..tostring(i+1).."}% "..
					"${color1}CPU"..tostring(i+2)..":$color ${goto 305}${cpu cpu"..tostring(i+2).."}% "..
					"${color1}CPU"..tostring(i+3)..":$color ${goto 390}${cpu cpu"..tostring(i+3).."}%\n"..
					"${cpubar cpu"..tostring(i).." 5,100} ${cpubar cpu"..tostring(i+1).." 5, 100} "..
					"${cpubar cpu"..tostring(i+2).." 5,100} ${cpubar cpu"..tostring(i+3).." 5, 100} "
		if i+4 < numcpus
		then
			listcpus = listcpus.."\n"
		end
	end
	return ""
end

function init_blks()
	-- todo show blks based on parameters
	return ""
end

function init_links()
	local handle = io.popen('ip a | grep "state UP" | cut -d: -f2 | tr -d " "')
    	local result = handle:read('*a'):gsub('\n$','')
    	handle:close()
	print(result)
	return ""
end

init_cpus()
init_blks()
init_links()

function conky_cpus()
	return listcpus
end
function conky_link()
	return listint
end
function conky_lsblk(tmp)
	blks = {}
	for blk in string.gmatch(tmp, "([^,]+)") do 
		table.insert(blks, blk)
	end
	return init_blks(blks)
end

