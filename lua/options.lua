vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.clipboard = "unnamedplus"

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true


vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true

vim.o.termguicolors = true
vim.o.pumborder = "+,-,+,|,+,-,+,|"
vim.o.pumheight = 15
vim.o.signcolumn = "yes"
vim.o.scrolloff = 8
vim.o.sidescrolloff = 16
vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true

vim.api.nvim_create_user_command("RandomChar", function () 
	local line = ""
	for j=0,200 do
		line = line .. string.char(math.random(33, 126))
	end
	vim.api.nvim_set_current_line(line)
end, {})
