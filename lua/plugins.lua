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
	"https://github.com/saghen/blink.cmp",
	"https://github.com/saghen/blink.lib"
}, { confirm = false })

local update = function ()
	vim.pack.update({
		"gruber-darker.nvim",
		"snacks.nvim",
		"trouble.nvim",
		"donut.nvim",
		"oil.nvim",
		"nvim-autopairs",
		"cord.nvim",
		"nvim-lspconfig",
		"typst-preview.nvim",
		"gitsigns.nvim",
		"nvim-colorizer.lua"
	})
end
vim.api.nvim_create_user_command("UpdatePlugins", update, {})

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

vim.api.nvim_create_autocmd('FileType', {
	callback = function(ev)
		local language = vim.treesitter.language.get_lang(ev.match) or ev.match
		if not vim.treesitter.language.add(language) then
			return
		end

		-- disable when it's too big
		local ok, stats = pcall(vim.uv.fs_stat,
		vim.api.nvim_buf_get_name(ev.buf))
		if ok and stats and stats.size > (1024 * 100 * 10) --[[1MB]] then
			return true
		end

		-- syntax highlighting
		vim.bo.syntax = 'ON' -- I like em both on
		pcall(vim.treesitter.start, ev.buf)

		-- indenting
		vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
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

vim.keymap.set("n", "gD", picker.lsp_declarations)
vim.keymap.set("n", "gd", picker.lsp_definitions)
vim.keymap.set("n", "gi", picker.lsp_implementations)
vim.keymap.set("n", "gr", picker.lsp_references)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

-------------------- Completion --------------------
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ctx)
-- 		local client = vim.lsp.get_client_by_id(ctx.data.client_id)
-- 		if not client or not client:supports_method("textDocument/completion") then
-- 			return
-- 		end
--
-- 		local trigger_characters = client.server_capabilities.completionProvider.triggerCharacters
-- 		if trigger_characters then
-- 			for i = 32, 127 do
-- 				local c = string.char(i)
--
-- 				if not table.contains(trigger_characters, c) then
-- 					table.insert(trigger_characters, c)
-- 				end
-- 			end
-- 		end
--
-- 		vim.keymap.set("i", "<C-j>", function()
-- 			return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-j>"
-- 		end, { expr = true, buf = ctx.buf })
--
-- 		vim.keymap.set("i", "<C-k>", function()
-- 			return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-k>"
-- 		end, { expr = true, buf = ctx.buf })
--
-- 		vim.keymap.set("i", "<Tab>", function()
-- 			return vim.fn.pumvisible() == 1 and "<C-y>" or "<Tab>"
-- 		end, { expr = true, buf = ctx.buf })
--
-- 		vim.lsp.completion.enable(true, client.id, ctx.buf, {
-- 			autotrigger = true,
-- 			convert = function(item)
-- 				return { abbr = item.label:gsub("%b()", "") }
-- 			end,
-- 		})
-- 	end
-- })

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
-- Local dev override — comment out the vim.pack line and use this instead
vim.opt.rtp:prepend("/home/eggbert/programs/lua/beepboop.nvim")
-- vim.pack.add({ "https://github.com/EggbertFluffle/beepboop.nvim" })

require("beepboop").setup({
	get_binary_method = "download",
	theme = "https://github.com/EggbertFluffle/mingleburb.beepboop",
})

-------------------- youreit.nvim --------------------
-- require("youreit").setup({
-- 	username = "Eggbert"
-- })

-------------------- glop.nvim --------------------
-- require("glop").setup()
