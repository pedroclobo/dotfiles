local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	vim.notify("lspconfig is not installed!")
	return
end

require("plugin.lsp.lsp-installer")
require("plugin.lsp.null-ls")
require("plugin.lsp.handlers").setup()
