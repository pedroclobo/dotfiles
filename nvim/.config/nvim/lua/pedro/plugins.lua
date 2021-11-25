local fn = vim.fn

-- Automatically install paq
local install_path = fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({"git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", install_path})
end

-- Plugins
require "paq" {

	-- General
	"savq/paq-nvim";
	"shaunsingh/nord.nvim";

	-- LSP
	"neovim/nvim-lspconfig";
	"williamboman/nvim-lsp-installer";

	-- Completion
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/nvim-cmp",
	"onsails/lspkind-nvim",
	"L3MON4D3/LuaSnip",

	-- Telescope
	"nvim-lua/plenary.nvim";
	"nvim-telescope/telescope.nvim";

	-- Misc
	"windwp/nvim-autopairs";

}
