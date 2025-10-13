vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({"n", "v"}, "j", "gj")
vim.keymap.set({"n", "v"}, "k", "gk")

vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("n", "C", "ciw")
