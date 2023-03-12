local present, lspkind = pcall(require, "lspkind")
if not present then return end

lspkind.init({
	symbol_map = {
		Copilot = "",
	},
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#a3be8c" })
