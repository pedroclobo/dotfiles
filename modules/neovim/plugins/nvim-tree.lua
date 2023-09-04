local tree = require "nvim-tree"

local function on_attach(bufnr)
	local api = require "nvim-tree.api"

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close")
end

tree.setup({
	on_attach = on_attach,

	disable_netrw = false, -- needed to download spell files
	hijack_cursor = true,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	sort = { sorter = "type" },
	sync_root_with_cwd = true,
	view = {
		width = 30,
		side = "right",
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
