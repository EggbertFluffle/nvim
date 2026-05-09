---@param any[]
---@param any
---@return bool
table.contains = function(list, val)
	for i, v in ipairs(list) do
		if v == val then return true end
	end
	return false
end

require("options")
require("plugins")
require("remaps")
require("autocmd")
