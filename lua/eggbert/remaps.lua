vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>cc", ":!make")
vim.keymap.set("n", "<leader>cr", ":!make && ./main")
vim.keymap.set("n", "<leader>cl", ":!pdflatex main.tex")

vim.keymap.set("v", "<C-/>", "yq/p<Enter>N")

vim.keymap.set("n", "<C-Enter>", function ()
	require("beepboop").play_audio("runprogram")

	local terminalCmd = "alacritty --command "
	local runScriptsPath = "/home/eggbert/.config/nvim/lua/eggbert/scripts/"

	local fileName = string.lower(vim.fn.expand("%"))
	local fileExtension = string.lower(fileName.sub(fileName, string.len(fileName) - 2, string.len(fileName)))

	if fileExtension == "ava" then -- RUN JAVA CODE
		if (string.find(fileName, "test") == nil) then
			print("RUN JAVA")
			os.execute(terminalCmd .. runScriptsPath .. "javarun.sh &")
		else
			print("RUN TESTS")
			os.execute(terminalCmd .. runScriptsPath .. "javatest.sh &")
		end
	elseif (fileExtension == "cpp" or fileExtension == "hpp" or string.sub(fileExtension, -1) == "c") then -- RUN C++ AND C
		os.execute(terminalCmd .. runScriptsPath .. "cpp.sh &")
	elseif (fileExtension == "lua") then -- RUN LUA CODE
		os.execute(terminalCmd .. runScriptsPath .. "lua.sh " .. fileName)
	elseif (fileExtension == "zig") then -- RUN LUA CODE
		os.execute(terminalCmd .. runScriptsPath .. "zigrun.sh " .. fileName)
	else
		print("ion know whut da phuq to do wit dis")
	end
end)

vim.keymap.set({"n", "v"}, "j", "gj")
vim.keymap.set({"n", "v"}, "k", "gk")

vim.keymap.set("i", "<C-Backspace>", "<C-w>")
vim.keymap.set({"i", "n"}, "<C-a>", "<C-c>ggVG")
vim.keymap.set("n", "C", "ciw")

zig_buf_write_ERRADICATED = false
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = {"*.zig"},
	callback = function(_)
		if not zig_buf_write_ERRADICATED then
			zig_buf_write_ERRADICATED = true
			vim.api.nvim_del_augroup_by_name("vim-zig")
		end
	end,
})
