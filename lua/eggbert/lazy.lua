local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = (function()
			local builtin = require('telescope.builtin')

			require("telescope").setup{
				defaults = {
					mappings = {
						i = {
							["<C-h>"] = "which_key",
							["<C-k>"] = "move_selection_previous",
							["<C-j>"] = "move_selection_next"
						}
					}
				}
			}

			vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
			vim.keymap.set('n', '<leader>ps', function() 
				builtin.grep_string({ search = vim.fn.input("Grep > ")})
			end)
		end),
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = (function() 
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "c", "cpp", "lua", "vim", "javascript", "html", "typescript", "css" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },  
			})
		end)
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			presets = {
				operators = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			},
		},
	},
	{
		'altermo/ultimate-autopair.nvim',
		event={'InsertEnter','CmdlineEnter'},
		branch='v0.6',
	},
	{ 'lewis6991/gitsigns.nvim' },
	{ "lukas-reineke/indent-blankline.nvim" },
	{
		'numToStr/Comment.nvim',
		lazy = false,
		config = function()
			require("Comment").setup()
		end,
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		},
		config = function()
			local lsp = require('lsp-zero').preset({})
			local cmp = require("cmp")

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({buffer = bufnr})
			end)

			cmp.setup({
				mapping={
					['<C-k>'] = cmp.mapping.select_prev_item(),
					['<C-j>'] = cmp.mapping.select_next_item(),
					['<Tab>'] = cmp.mapping.confirm({select = true}),
				}
			})

			lsp.setup()
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
			vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

			vim.keymap.set("n", "<C-k>", function() harpoon:list():prev() end)
			vim.keymap.set("n", "<C-j>", function() harpoon:list():next() end)
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require("lualine").setup({
				options = { theme = 'gruvbox' }
			})
		end,
	},
	{ 'eandrju/cellular-automaton.nvim' },
	{
		'mbbill/undotree',
		config = function()
			vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
		end,
	},
	{
    	'tamton-aquib/duck.nvim',
    	config = function()
        	vim.keymap.set('n', '<leader>dd', function() require("duck").hatch() end, {})
        	vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
    	end
	},
	{
		'windwp/nvim-autopairs',
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{ "alec-gibson/nvim-tetris" }
})
