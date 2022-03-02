local fn = vim.fn
local cmd = vim.cmd

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	cmd [[packadd packer.nvim]]
end

-- Reload neovim whenever plugins.lua is written
cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

-- Use a protected call to prevent errors
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Use a popup window for packer
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Plugins
return packer.startup(function(use)

	-- General
	use "wbthomason/packer.nvim"
	use "nvim-lua/popup.nvim"
	use "nvim-lua/plenary.nvim"

	-- Colorschemes
	use "shaunsingh/nord.nvim"

	-- LSP
	use "neovim/nvim-lspconfig"
	use "williamboman/nvim-lsp-installer"

	-- Completion
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-cmdline"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-nvim-lua"

	-- Snipets
	use "L3MON4D3/LuaSnip"
	use "rafamadriz/friendly-snippets"

	-- Telescope
	use "nvim-telescope/telescope.nvim"

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	}

	-- Misc
	use "windwp/nvim-autopairs"
	use "lewis6991/gitsigns.nvim"

	-- Set up configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end

end)
