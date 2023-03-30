local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local formatters = {
	clang_format = {
		extra_args = {
			"--style",
			"{UseTab: ForIndentation, IndentWidth: 8, SortIncludes: true, PointerAlignment: Right, SortUsingDeclarations: false}",
		},
	},
	rustfmt = {
		extra_args = {
			"--config",
			"hard_tabs=true",
		},
	},
	shfmt = {
		extra_args = {
			"--keep-padding",
			"--space-redirects",
			"--switch-case-indent",
		},
	},
	stylua = {
		extra_args = {
			"--call-parentheses",
			"NoSingleString",
			"--quote-style",
			"ForceDouble",
			"--collapse-simple-statement",
			"Always",
		},
	},
	yapf = {
		extra_args = {
			"--style",
			"{use_tabs: True}",
		},
	},
}

null_ls.setup({
	debug = false,
	sources = {
		diagnostics.shellcheck,
		formatting.clang_format.with(formatters["clang_format"]),
		formatting.rustfmt.with(formatters["rustfmt"]),
		formatting.shfmt.with(formatters["shfmt"]),
		formatting.stylua.with(formatters["stylua"]),
		formatting.yapf.with(formatters["yapf"]),
	},
})
