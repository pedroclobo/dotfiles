local telescope = require "telescope"

telescope.setup({
	defaults = {
		layout_strategy = "bottom_pane",
		layout_config = {
			bottom_pane = {
				height = 10,
				preview_cutoff = 120,
				prompt_position = "bottom",
			},
		},
		prompt_prefix = "> ",
		selection_caret = "  ",
		entry_caret = "  ",
	},
	pickers = {
		find_files = {
			previewer = false,
		},
	},
})

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>Telescope live_grep<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>Telescope buffers<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>Telescope help_tags<CR>", opts)
