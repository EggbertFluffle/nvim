vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({"n", "v"}, "j", "gj")
vim.keymap.set({"n", "v"}, "k", "gk")

vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("n", "C", "ciw")

-- Run command
vim.keymap.set("n", "<C-Enter>", function ()
	local lookup = {
		lua = "lua.sh",

		cpp = "make.sh",
		c = "make.sh",
		hpp = "make.sh",
		h = "make.sh",

		zig = "zigrun.sh",
	}

	local scripts_dir = vim.fn.stdpath("config") .. "/scripts/"
	local filetype = vim.bo.filetype
	local filename = vim.fn.expand("%s")

	vim.uv.spawn("alacritty", {
		detached = true,
		args = { "--command", scripts_dir .. lookup[filetype], filename }
	}, function () end)
end)
