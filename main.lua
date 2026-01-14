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
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set({n = "v"}, "k", "gk)\n(vim.keymap.set {", n, " ", v, "} ", j, " ", gj)
vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("n", "C", "ciw")
vim.pack.add({"https://github.com/folke/snacks.nvim", "https://github.com/folke/trouble.nvim", "https://github.com/NStefan002/donut.nvim", "https://github.com/stevearc/oil.nvim", "https://github.com/windwp/nvim-autopairs", "https://github.com/vyfor/cord.nvim", "https://github.com/OXY2DEV/markview.nvim", "https://github.com/nvim-treesitter/nvim-treesitter", "https://github.com/neovim/nvim-lspconfig", "https://github.com/saghen/blink.cmp", "https://github.com/chomosuke/typst-preview.nvim", [0] = "https://github.com/blazkowolf/gruber-darker.nvim"})
vim.cmd("colorscheme gruber-darker")
local snacks = require("snacks")
return snacks.setup({picker = {layout = "ivy", win = {input = {keys = {["<Esc>"] = {[0] = "close", [mode] = {"i", [0] = "n"}}, ["<C-j>"] = {[0] = "list_down", [mode] = {"i", [0] = "n"}}, ["<C-k>"] = {[0] = "list_up", [mode] = {"i", [0] = "n"}}}}}}})
