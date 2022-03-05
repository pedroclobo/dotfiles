-- Protected call to null-ls
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	print("null-ls not installed!")
	return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = false,
	sources = {
		formatting.clang_format.with({ extra_args = { "--style", "{UseTab: ForIndentation, IndentWidth: 8}" } }),
		formatting.rustfmt.with({ extra_args = { "--config", "hard_tabs=true" } }),
		formatting.stylua,
		formatting.yapf.with({ extra_args = { "--style", "{use_tabs: True}" } }),
	},
})
