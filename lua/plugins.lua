------------------ Colorschemes --------------------
vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })
vim.pack.add({ "https://github.com/ficcdaf/ashen.nvim" })
vim.pack.add({ "https://github.com/blazkowolf/gruber-darker.nvim" })

vim.cmd("colorscheme gruber-darker")

-------------------- Snacks.Picker --------------------
vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require("snacks").setup({
	picker = {
		layout = "ivy",
		win = {
			input = {
				keys = {
					["<Esc>"] = { "close", mode = { "n", "i" } },
					["<C-j>"] = { "list_down", mode = { "i", "n" } },
					["<C-k>"] = { "list_up", mode = { "i", "n" } },
				}
			}
		}
	}
})

local picker = require("snacks").picker;
vim.keymap.set("n", "<leader>pf", function () picker.files() end)
vim.keymap.set("n", "<leader>ps", function () picker.grep() end)
vim.keymap.set("n", "<leader>pb", function () picker.buffers() end)
vim.keymap.set("n", "<leader>pk", function () picker.keymaps() end)
vim.keymap.set("n", "<leader>pi", function () picker().icons() end)
vim.keymap.set("n", "<leader>pp", function () picker() end)

-------------------- Trouble --------------------
vim.pack.add({ "https://github.com/folke/trouble.nvim" })
require("trouble").setup()
vim.keymap.set("n", "<leader>ce", function() require("trouble").toggle("diagnostics") end)
vim.keymap.set("n", "<leader>cs", function() require("trouble").toggle("symbols") end)

-------------------- Donut --------------------
vim.pack.add({ "https://github.com/NStefan002/donut.nvim" })
require("donut").setup({
	timeout = 180,
	sunc_donuts = true,
})

-------------------- Oil --------------------
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
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
vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })
require("nvim-autopairs").setup({
	map_bs = false,
	map_cr = false
})

-------------------- Cord --------------------
vim.pack.add({ "https://github.com/vyfor/cord.nvim" })
require("cord").setup()
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(opts)
		if opts.data.spec.name == "cord.nvim" and opts.data.kind == "update" then
			vim.cmd("Cord update")
		end
	end
})

-------------------- Markview --------------------
vim.pack.add({ "https://github.com/OXY2DEV/markview.nvim" })
require("markview").setup({
	preview = {
		enable = true,
	}
})

-------------------- Treesitter --------------------
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
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
		"zig"
	},
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})

-------------------- LSP --------------------
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.lsp.enable({
	"lua_ls",
	"zls",
	"clangd",
	"svelte-language-server",
	"tinymist",
	"typescript-langauge-server"
})
vim.lsp.log_levels = "off"

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
vim.pack.add({ "https://github.com/saghen/blink.cmp" })
require("blink.cmp").setup({
	completion = {
		documentation = {
			auto_show = true,
			window = { border = "single" }
		},
		menu = { border = "single" },
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
vim.pack.add({ "https://github.com/chomosuke/typst-preview.nvim" })
require("typst-preview").setup()
