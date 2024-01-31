return {
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
}
