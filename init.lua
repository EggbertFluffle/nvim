local tmpfile = "/tmp/lua_fennel_conf"
local config = "~/.config/nvim/start.fnl"
local exit = os.execute("fennel -c " .. config .. " > " .. tmpfile .. " 2> " .. tmpfile)
local file, err = io.open(tmpfile, "r")
if err then error(err) end
local output = file:read("*a")

if exit ~= 0 then 
	error(output)
end

dofile(tmpfile)
