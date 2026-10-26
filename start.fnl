(tset vim.g :mapleader " ")
(local opts {
	   :number true
	   :relativenumber true
	   :clipboard "unnamedplus"
	   :tabstop 4
	   :shiftwidth 4
	   :smartindent true

	   :hlsearch false
	   :incsearch true
	   :ignorecase true

	   :termguicolors true
	   :pumheight 15
	   :signcolumn "yes"
	   :scrolloff 8
	   :sidescrolloff 16
	   :wrap false

	   :completeopt ["menuone" "noinsert"]

	   :swapfile false
	   :backup false
	   :undofile true})

(each [key value (pairs opts)]
  (tset vim.opt key value))

(vim.pack.add 
  ["https://github.com/blazkowolf/gruber-darker.nvim"
   "https://github.com/stevearc/oil.nvim"
   "https://github.com/windwp/nvim-autopairs"
   { :src "https://github.com/nvim-treesitter/nvim-treesitter" :version "main" }
   "https://github.com/neovim/nvim-lspconfig"]
  { :confirm true })

(vim.cmd "colorscheme gruber-darker")

(fn setup [module options]
  ((. (require module) :setup) options))

(setup "nvim-autopairs" { :map_bs false :map_cr false })

(local tree-sitter (require "nvim-treesitter"))

(tree-sitter.setup)
(tree-sitter.install ["c" "cpp" "lua" "vim" "javascript" "html" "css" "svelte"
					  "typescript" "zig" "typst" "fennel" "haskell" "bash" "gdscript"])

(vim.api.nvim_create_autocmd 
  :FileType 
  {:callback 
  (fn [args]
	(when (pcall vim.treesitter.start args.buf)
	  (tset vim.bo args.buf :indentexpr
			"v:lua.require'nvim-treesitter'.indentexpr()")))})

(setup "oil" {
	   :default_file_explorer true
	   :columns ["permissions" "size"]
	   :constrain_cursor "editable"
	   :skip_confirm_for_simple_edits true
	   :watch_for_change true
	   :view_options { :show_hidden true :natural_order true }
	   :float { :preview_win "fast_scratch" :preview_split "right" }
	   :keymaps { "_" false } })
(vim.keymap.set "n" "<leader>pv" "<CMD>Oil<CR>")
