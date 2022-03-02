-- Protected call to lsp-installer
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	print("nvim-lsp-installer not installed!")
	return
end

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("plugin.lsp.handlers").on_attach,
		capabilities = require("plugin.lsp.handlers").capabilities,
	}

	 if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("plugin.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	 end

	 if server.name == "pyright" then
	 	local pyright_opts = require("plugin.lsp.settings.pyright")
	 	opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	 end

	server:setup(opts)
end)
