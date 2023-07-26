local tree = require "nvim-tree"
local config = require "nvim-tree.config"

tree.setup({
	disable_netrw = false, -- needed to download spell files
	hijack_cursor = true,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	sort = { sorter = "type" },
	sync_root_with_cwd = true,
	view = {
		width = 30,
		side = "right",
		mappings = {
			custom_only = false,
			list = {
				{ key = "l", cb = config.nvim_tree_callback "edit" },
				{ key = "h", cb = config.nvim_tree_callback "close_node" },
			},
		},
	},
	renderer = {
		highlight_git = false,
		indent_markers = {
			enable = false,
			inline_arrows = true,
		},
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
			},
			glyphs = {
				default = "󰈚",
				symlink = "",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
})
