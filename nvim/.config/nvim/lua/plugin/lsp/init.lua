-- Protected call to lspconfig
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	print("lspconfig not installed!")
	return
end

require("plugin.lsp.lsp-installer")
require("plugin.lsp.null-ls")
require("plugin.lsp.handlers").setup()
