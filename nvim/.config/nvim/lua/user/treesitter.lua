local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	vim.notify("Failed to load nvim-treesitter.configs!")
	return
end

configs.setup({
	ensure_installed = "all",
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	autotag = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	rainbow = {
		enable = true,
	},
})
