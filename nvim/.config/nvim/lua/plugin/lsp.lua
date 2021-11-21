local lsp_installer = require "nvim-lsp-installer"

-- Call all installed servers
lsp_installer.on_server_ready(function(server)
	local opts = {}
	server:setup(opts)
end)

-- Plugin configuration
lsp_installer.settings({
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗"
		}
	}
})

-- Keymaps
vim.api.nvim_buf_set_keymap(0, "n", "<leader>vsh", ":lua vim.lsp.buf.signature_help()<CR>", { silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>vh", ":lua vim.lsp.buf.hover()<CR>", { silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>vr", ":lua vim.lsp.buf.references()<CR>", { silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>", { silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>r", ":lua vim.lsp.buf.rename()<CR>", { silent = true })
