local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	vim.notify("lspconfig is not installed!")
	return
end

require("user.lsp.lsp-installer")
require("user.lsp.null-ls")
require("user.lsp.handlers").setup()
