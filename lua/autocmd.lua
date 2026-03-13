vim.api.nvim_create_autocmd("FileType", {
	pattern = {"markdown", "typst", "text", "gitcommit"},
	callback = function()
		vim.opt_local.wrap = true
		vim.lsp.enable("harper_ls")
	end
})
