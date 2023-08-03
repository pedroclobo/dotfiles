local formatter = require "formatter"
local util = require "formatter.util"

vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>Format<CR>", { noremap = true, silent = true })

formatter.setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		c = {
			function()
				return {
					exe = "clang-format",
					args = {
						"--style=\"{UseTab: ForIndentation, IndentWidth: 8, SortIncludes: true, PointerAlignment: Right, SortUsingDeclarations: false}\"",
					},
					stdin = true,
				}
			end,
		},
		cpp = {
			function()
				return {
					exe = "clang-format",
					args = {
						"--style=\"{UseTab: ForIndentation, IndentWidth: 8, SortIncludes: true, PointerAlignment: Right, SortUsingDeclarations: false}\"",
					},
					stdin = true,
				}
			end,
		},
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
						"--call-parentheses",
						"NoSingleString",
						"--quote-style",
						"ForceDouble",
						"--collapse-simple-statement",
						"Always",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
		ocaml = {
			function()
				return {
					exe = "ocamlformat",
					args = {
						"--enable-outside-detected-project",
						util.escape_path(util.get_current_buffer_file_name()),
					},
					stdin = true,
				}
			end,
		},
		python = {
			function()
				return {
					exe = "yapf",
					args = {
						"--style=\"{use_tabs: True}\"",
					},
					stdin = true,
				}
			end,
		},
		rust = {
			function()
				return {
					exe = "rustfmt",
					args = {
						"--config",
						"hard_tabs=true",
					},
					stdin = true,
				}
			end,
		},
		sh = {
			function()
				return {
					exe = "shfmt",
					args = {
						"--keep-padding",
						"--space-redirects",
						"--case-indent",
					},
					stdin = true,
				}
			end,
		},
	},
})
