vim.pack.add({
	"https://github.com/blazkowolf/gruber-darker.nvim",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/NStefan002/donut.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/vyfor/cord.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/chomosuke/typst-preview.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/saghen/blink.lib",
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" }
})

------------------ Colorschemes --------------------
vim.cmd("colorscheme gruber-darker")

-------------------- Snacks.Picker --------------------
require("snacks").setup({
	picker = {
		layout = "ivy", win = {
			input = {
				keys = {
					["<Esc>"] = { "close", mode = { "n", "i" } },
					["<C-j>"] = { "list_down", mode = { "n", "i" } },
					["<C-k>"] = { "list_up", mode = { "n", "i" } },
				}
			}
		}
	}
})

local picker = require("snacks").picker;
vim.keymap.set("n", "<leader>pf", function () picker.smart() end)
vim.keymap.set("n", "<leader>ps", function () picker.grep() end)
vim.keymap.set("n", "<leader>pd", function () picker.lsp_symbols({ filter = { default = { "Function", "Method", "Class" } } }) end)
vim.keymap.set("n", "<leader>pk", function () picker.keymaps() end)
vim.keymap.set("n", "<leader>pi", function () picker.icons() end)

vim.keymap.set("n", "<leader>pp", function () picker() end)

-------------------- Trouble --------------------
require("trouble").setup()
vim.keymap.set("n", "<leader>ce", function() require("trouble").toggle("diagnostics") end)
vim.keymap.set("n", "<leader>cs", function() require("trouble").toggle("symbols") end)

-------------------- Donut --------------------
require("donut").setup({
	timeout = 180,
	sunc_donuts = true,
})

-------------------- Oil --------------------
require("oil").setup({
	default_file_explorer = true,
	columns = {
		"permissions",
		"size",
		"icon"
	},
	constrain_cursor = "name",
	view_options = {
		show_hidden = true,
		natural_order = true,
	},
	preview_win = {
		preview_method = "fast_scratch"
	}
})
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")

-------------------- Autopairs --------------------
require("nvim-autopairs").setup({
	map_bs = false,
	map_cr = false
})

-------------------- Cord --------------------
require("cord").setup()
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(opts)
		if opts.data.spec.name == "cord.nvim" and opts.data.kind == "update" then
			vim.cmd("Cord update")
		end
	end
})

-------------------- Treesitter --------------------
require("nvim-treesitter").setup({
	ensure_installed = {
		"c",
		"cpp",
		"lua",
		"vim",
		"javascript",
		"html",
		"css",
		"svelte",
		"typescript",
		"zig",
		"typst",
		"fennel",
		"haskell",
		"bash",
		"gdscript"
	},
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})

-------------------- LSP --------------------
vim.lsp.enable({
	"lua_ls",
	"zls",
	"clangd",
	"tinymist",
	"svelte",
	"ts_ls",
	"html",
	"cssls",
	"elixirls",
	"rust_analyzer",
	"jdtls",
	"fennel_ls",
	"hls",
	"gdscript",
	"tailwindcss"
})
vim.lsp.log_levels = "off"

vim.lsp.config('elixirls', {
    cmd = { "/home/eggbert/.local/src/elixir-ls/language_server.sh" }
})

-- vim.lsp.config("fennel-ls")

vim.keymap.set("n", "gD", picker.lsp_declarations)
vim.keymap.set("n", "gd", picker.lsp_definitions)
vim.keymap.set("n", "gi", picker.lsp_implementations)
vim.keymap.set("n", "gr", picker.lsp_references)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

-------------------- Blink.cmp --------------------
require("blink.cmp").setup({
	fuzzy = {
		implementation = "lua",
	},
	completion = {
		documentation = {
			auto_show = true,
		},
	},
	keymap = {
		preset = "none",
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "select_and_accept", "fallback" },
		["<C-n>"] = { "scroll_documentation_down", "fallback" },
		["<C-p>"] = { "scroll_documentation_up", "fallback" },
	}
})

-------------------- Typst Preview --------------------
require("typst-preview").setup()

-------------------- gitsigns.nvim --------------------
require("gitsigns").setup()

-------------------- BeepBoop.nvim --------------------
-- vim.pack.add({ "beepboop.nvim" })
-- require("beepboop").setup({
-- 	binary_path = "/home/eggbert/programs/lua/beepboop.nvim/zig-out/bin/",
-- 	theme = "https://github.com/EggbertFluffle/mingleburb.beepboop"
-- })
