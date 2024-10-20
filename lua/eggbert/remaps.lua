vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>cc", ":!make")
vim.keymap.set("n", "<leader>cr", ":!make && ./main")
vim.keymap.set("n", "<leader>cl", ":!pdflatex main.tex")

-- Gross ass autorun command 
vim.keymap.set("n", "<C-Enter>", function ()
	local terminalCmd = "alacritty --command "
	local runScriptsPath = "/home/eggbert/.config/nvim/lua/eggbert/"

	local fileName = vim.fn.expand("%")
	local fileExtension = fileName.sub(fileName, string.len(fileName) - 3, string.len(fileName))

	if fileExtension == "java" then
		os.execute(terminalCmd .. runScriptsPath .. "java.sh " .. fileName)
	else
		os.execute(terminalCmd .. runScriptsPath .. "cpp.sh")
	end
end)

vim.api.nvim_create_autocmd({'BufWritePost'}, {
	pattern = "*.tex",
	command = "!pdflatex main.tex"
})

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<C-j>", "5j");
vim.keymap.set("n", "<C-k>", "5k");

vim.keymap.set("i", "<C-Backspace>", "<C-w>")
