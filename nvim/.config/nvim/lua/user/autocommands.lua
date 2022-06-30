-- Remove trailing white space on file write
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd([[silent! %s/\s\+$//e]])
	end,
})
