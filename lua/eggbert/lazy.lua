local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
	})
end vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({ })
			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = (function()
			local builtin = require("telescope.builtin")

			require("telescope").setup{
				defaults = {
					mappings = {
						i = {
							["<C-k>"] = "move_selection_previous",
							["<C-j>"] = "move_selection_next"
						}
					}
				}
			}

			vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ")})
			end)
		end),
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "c", "cpp", "lua", "vim", "javascript", "html", "typescript", "css" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig");
			lspconfig.arduino_language_server.setup({
				cmd = {
					"arduino-language-server",
					"-cli-config", "/home/eggbert/.arduino15/arduino-cli.yaml",
					"-fqbn",
					"arduino/avr/uno"
				}
			})
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{"neovim/nvim-lspconfig"},
			{"williamboman/mason.nvim"},
			{"williamboman/mason-lspconfig.nvim"},
			{"hrsh7th/nvim-cmp"},
			{"hrsh7th/cmp-nvim-lsp"},
			{"L3MON4D3/LuaSnip"},
			{'folke/lua-dev.nvim'},
		},
		config = function()
			local lsp = require("lsp-zero").preset({})
			local cmp = require("cmp")

			lsp.on_attach(function(_, buf)
				lsp.default_keymaps({buffer = buf})
			end)

			cmp.setup({
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<Tab>"] = cmp.mapping.confirm({select = true}),
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

			vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
			vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

			vim.keymap.set("n", "<C-k>", function() harpoon:list():prev() end)
			vim.keymap.set("n", "<C-j>", function() harpoon:list():next() end)
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = { theme = "gruvbox" }
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.keymap.set("n", "<leader>ce", function() require("trouble").toggle("diagnostics") end)
			vim.keymap.set("n", "<leader>cs", function() require("trouble").toggle("symbols") end)
		end,
	},
	{
		"NStefan002/donut.nvim",
		version = "*",
		lazy = false,
		config = function()
			require("donut").setup({
				timeout = 180
			})
		end,
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			view_options = {
				show_hidden = true,
				natural_order = true,
			},
		},
	},
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_enable = false
			vim.cmd("Copilot disable")
		end,
	},
	{
		dir = "/home/eggbert/programs/lua/beepboop.nvim",
		opts = {
			audio_player = "paplay",
			volume = 100,
			sound_directory = "/home/eggbert/.config/nvim/sounds",
			sound_map = {
				{ key_map = { mode = "n", key_chord = "<leader>pv" }, sound = "chestopen.oga" },
				{ key_map = { mode = "n", key_chord = "<C-Enter>" }, sound = "chestopen.oga" },
				{ auto_command = "VimEnter", sound = "chestopen.oga" },
				{ auto_command = "VimLeave", sound = "chestclosed.oga" },
				{ auto_command = "InsertCharPre", sounds = {"stone1.oga", "stone2.oga", "stone3.oga", "stone4.oga"} },
				{ auto_command = "TextYankPost", sounds = {"hit1.oga", "hit2.oga", "hit3.oga"} },
				{ auto_command = "BufWrite", sounds = {"open_flip1.oga", "open_flip2.oga", "open_flip3.oga"} },
			}
		}
	}
})

