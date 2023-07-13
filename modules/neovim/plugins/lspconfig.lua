local lsp = require "lspconfig"

local handlers = {}

-- Illuminate
local function highlight(client)
	local illuminate = require "illuminate"
	illuminate.on_attach(client)
end

-- LSP specific keymaps
local function keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap

	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float({ border = \"rounded\" })<CR>", opts)
	keymap(bufnr, "n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap(bufnr, "n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

-- Define on_attach
handlers.on_attach = function(client, bufnr)
	highlight(client)
	keymaps(bufnr)

	-- Disable autoformat
	client.server_capabilities.document_formatting = false
	client.server_capabilities.document_range_formatting = false
end

-- Attach cmp completions
local cmp_nvim_lsp = require "cmp_nvim_lsp"
local capabilities = vim.lsp.protocol.make_client_capabilities()
handlers.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local opts = {
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
}

-- Rust
lsp.rust_analyzer.setup(opts)

-- Lua
local lua_opts = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand "$VIMRUNTIME/lua"] = true,
					[vim.fn.stdpath "config" .. "/lua"] = true,
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
lua_opts = vim.tbl_deep_extend("force", opts, lua_opts)
lsp.lua_ls.setup(lua_opts)

-- Nix
lsp.rnix.setup(opts)

-- Python
lsp.pyright.setup(opts)

-- C/C++
lsp.clangd.setup(opts)
local notify = vim.notify
vim.notify = function(msg, ...)
	if msg:match "warning: multiple different client offset_encodings" then return end
	notify(msg, ...)
end
