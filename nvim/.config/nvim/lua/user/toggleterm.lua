local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	vim.notify("Failed to require toggleterm!")
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-t>]],
	hide_numbers = true,
	shading_factor = 2,
	persist_size = true,
	direction = "float",
	float_opts = {
		border = "curved",
		winblend = 0,
	},
})
