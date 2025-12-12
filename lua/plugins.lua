vim.pack.add({
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/ficcdaf/ashen.nvim",
	"https://github.com/blazkowolf/gruber-darker.nvim",
	"https://github.com/rktjmp/lush.nvim",
	"https://github.com/zenbones-theme/zenbones.nvim",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/NStefan002/donut.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/vyfor/cord.nvim",
	"https://github.com/OXY2DEV/markview.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/chomosuke/typst-preview.nvim",
	"https://github.com/nvzone/volt",
	"https://github.com/gisketch/triforce.nvim",
	"https://github.com/gruvw/strudel.nvim",
	"https://github.com/petermused/subway-surfers.nvim",
})

------------------ Colorschemes --------------------
vim.cmd("colorscheme zenbones")

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

-------------------- Markview --------------------
-- require("markview").setup({
-- 	preview = {
-- 		enable = true,
-- 	},
-- 	typst = {
-- 		enabled = false,
-- 	}
-- })

-------------------- Treesitter --------------------
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"cpp",
		"lua",
		"vim",
		"javascript",
		"html",
		"typescript",
		"css",
		"zig",
		"typst"
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
	"rust_analyzer"
})
vim.lsp.log_levels = "off"

vim.lsp.config('elixirls', {
    cmd = { "/home/eggbert/.local/src/elixir-ls/language_server.sh" }
})

vim.keymap.set("n", "gD", picker.lsp_declarations)
vim.keymap.set("n", "gd", picker.lsp_definitions)
vim.keymap.set("n", "gi", picker.lsp_implementations)
vim.keymap.set("n", "gr", picker.lsp_references)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

-- vim.api.nvim_create_autocmd('LspAttach', {
-- 	group = vim.api.nvim_create_augroup('my.lsp', {}),
-- 	callback = function(ev)
-- 		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
--
-- 		if client:supports_method('textDocument/completion') then
-- 			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
-- 			client.server_capabilities.completionProvider.triggerCharacters = chars
--
-- 			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
-- 		end
--
-- 		local opts = { buffer = ev.buf }
-- 		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
-- 		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
-- 		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
-- 		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
-- 		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
-- 	end,
-- })
-- vim.opt.updatetime = 250
-- vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
--
-- vim.keymap.set("i", "<C-Space>", function ()
-- 	vim.lsp.completion.get()
-- end)
--
-- vim.keymap.set("i", "<C-j>", function ()
-- 	if vim.fn.pumvisible() == 1 then
-- 		return "<C-n>"
-- 	else
-- 		return "<C-j>"
-- 	end
-- end, { expr = true })
--
-- vim.keymap.set("i", "<C-k>", function ()
-- 	if vim.fn.pumvisible() == 1 then
-- 		return "<C-p>"
-- 	else
-- 		return "<C-k>"
-- 	end
-- end, { expr = true })
--
-- vim.keymap.set("i", "<Tab>", function ()
-- 	if vim.fn.pumvisible() == 1 then
-- 		return "<C-y>"
-- 	else
-- 		return "<Tab>"
-- 	end
-- end, { expr = true })

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

-------------------- Triforce --------------------
require("triforce").setup({})

-------------------- Strudel --------------------
require("strudel").setup()

-------------------- BeepBoop.nvim --------------------
-- vim.pack.add({ "beepboop.nvim" })
-- require("beepboop").setup({
-- 	binary_path = "/home/eggbert/programs/lua/beepboop.nvim/zig-out/bin/",
-- 	theme = "https://github.com/EggbertFluffle/mingleburb.beepboop"
-- })

-------------------- Subway-Surfers.nvim --------------------
require("subway-surfers").setup()
