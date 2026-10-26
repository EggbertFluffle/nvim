vim.pack.add({
	"https://github.com/blazkowolf/gruber-darker.nvim",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/NStefan002/donut.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/vyfor/cord.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/chomosuke/typst-preview.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/saghen/blink.lib",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/kawre/leetcode.nvim"
}, { confirm = false })

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
vim.keymap.set("n", "<leader>pf", function () picker.files() end)
vim.keymap.set("n", "<leader>ps", function () picker.grep() end)
vim.keymap.set("n", "<leader>pd", function () picker.lsp_symbols({ filter = { default = { "Function", "Method", "Class" } } }) end)
vim.keymap.set("n", "<leader>pk", function () picker.keymaps() end)
vim.keymap.set("n", "<leader>pi", function () picker.icons() end)

vim.keymap.set("n", "<C-/>", function () picker.lines() end)

vim.keymap.set("n", "<leader>pp", function () picker() end)

-------------------- Trouble --------------------
require("trouble").setup()
vim.keymap.set("n", "<leader>ce", "<cmd>Trouble diagnostics toggle<cr>")

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
		"size"
	},
	constrain_cursor = "editable",
	skip_confirm_for_simple_edits = true,
	watch_for_change = true,
	view_options = {
		show_hidden = true,
		natural_order = true,
	},
	float = {
		preview_split = "right"
	},
	preview_win = {
		preview_method = "fast_scratch",
		preview_split = "right"
	},
	keymaps = {
		["_"] = false,
		["<CR>"] = {
			callback = function()
				local oil = require("oil")
				local entry = oil.get_cursor_entry()

				if not entry then
					return
				end

				local media_ext = {
					-- images
					png = true, jpg = true, jpeg = true, gif = true, webp = true, bmp = true, svg = true,
					-- videos
					mp4 = true, mkv = true, mov = true, avi = true, webm = true, flv = true, ogg = true,
					-- other
					pdf = true,
				}

				local ext = entry.name:match("^.+%.(.+)$")
				ext = ext and ext:lower()

				if entry.type == "file" and ext and media_ext[ext] then
					local dir = oil.get_current_dir()
					local path = dir .. entry.name
					vim.ui.open(path)
					return
				end

				-- fall back to default oil behavior for everything else
				require("oil.actions").select.callback()
			end,
			desc = "Open media externally, otherwise default oil select",
		},
	}
})

-- I would like to thank claude for this wonderful addition to oil
vim.api.nvim_create_autocmd("User", {
	pattern = "OilActionsPost",
	callback = function(event)
		local image_ext = {
			png = true, jpg = true, jpeg = true, gif = true,
			bmp = true, webp = true, tiff = true, tif = true,
			heic = true, avif = true,
		}

		local im_cmd = vim.fn.executable("magick") == 1 and "magick" or "convert"

		for _, action in ipairs(event.data.actions) do
			if action.type == "move" then
				local src = action.src_url:gsub("^oil://", "")
				local dest = action.dest_url:gsub("^oil://", "")
				local src_ext = src:match("^.+%.([^.]+)$")
				local dest_ext = dest:match("^.+%.([^.]+)$")
				src_ext = src_ext and src_ext:lower()
				dest_ext = dest_ext and dest_ext:lower()

				if src_ext and dest_ext and src_ext ~= dest_ext
					and image_ext[src_ext] and image_ext[dest_ext] then
					local tmp = dest .. ".converting.tmp"

					vim.system(
						{ im_cmd, dest, tmp },
						{ text = true },
						function(res)
							vim.schedule(function()
								if res.code == 0 then
									os.rename(tmp, dest)
									vim.notify(
										("Converted %s -> .%s"):format(
											vim.fn.fnamemodify(src, ":t"),
											dest_ext
										),
										vim.log.levels.INFO
									)
								else
									os.remove(tmp)
									vim.notify(
										"ImageMagick conversion failed:\n" .. (res.stderr or ""),
										vim.log.levels.ERROR
									)
								end
							end)
						end
					)
				end
			end
		end
	end,
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
		-- vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-------------------- LSP --------------------
vim.lsp.enable({
	"lua_ls",
	"pylsp",
	"luau_lsp",
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
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	completion = {
		documentation = {
			auto_show = true,
		},
		trigger = {
			show_on_keyword = true,
			show_on_insert_on_trigger_character = true,
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
-- vim.opt.rtp:prepend("/home/eggbert/programs/lua/beepboop.nvim")

vim.pack.add({ { src = "https://github.com/EggbertFluffle/beepboop.nvim", version = "main" } })

require("beepboop").setup({
	-- mute = true,
	get_binary_method = "download",
	-- binary_path = "/home/eggbert/programs/zig/boopbeep/zig-out/bin/boopbeep",
	theme = "https://github.com/EggbertFluffle/typewriter.beepboop"
})

-------------------- leetcode.nvim --------------------
require("leetcode").setup({
	lang = "c"
})
