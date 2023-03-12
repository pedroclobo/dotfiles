{ pkgs, config, lib, ... }:

let
	cfg = config.modules.neovim;
	inherit (lib) mkEnableOption mkIf;
in {
	options.modules.neovim.enable = mkEnableOption "neovim";

	config.hm = mkIf cfg.enable {
		home.packages = with pkgs; [
			rnix-lsp
			nixfmt
			shfmt
			sumneko-lua-language-server
			stylua
			rust-analyzer
			rustfmt
			yapf
			ripgrep
		];

		programs = {
			neovim = {
				enable = true;
				viAlias = true;
				vimdiffAlias = true;
				defaultEditor = true;
				extraLuaConfig = builtins.concatStringsSep "\n" [
					# General
					(lib.strings.fileContents ./general/autocommands.lua)
					(lib.strings.fileContents ./general/colorscheme.lua)
					(lib.strings.fileContents ./general/keymaps.lua)
					(lib.strings.fileContents ./general/options.lua)

					# Plugins
					(lib.strings.fileContents ./plugins/alpha.lua)
					(lib.strings.fileContents ./plugins/autopairs.lua)
					(lib.strings.fileContents ./plugins/cmp.lua)
					(lib.strings.fileContents ./plugins/comment.lua)
					(lib.strings.fileContents ./plugins/copilot.lua)
					(lib.strings.fileContents ./plugins/gitsigns.lua)
					(lib.strings.fileContents ./plugins/lspkind.lua)
					(lib.strings.fileContents ./plugins/lualine.lua)
					(lib.strings.fileContents ./plugins/luasnip.lua)
					(lib.strings.fileContents ./plugins/lspconfig.lua)
					(lib.strings.fileContents ./plugins/nvim-tree.lua)
					(lib.strings.fileContents ./plugins/null-ls.lua)
					(lib.strings.fileContents ./plugins/presence.lua)
					(lib.strings.fileContents ./plugins/spellsitter.lua)
					(lib.strings.fileContents ./plugins/telescope.lua)
					(lib.strings.fileContents ./plugins/treesitter.lua)
				];
				plugins = with pkgs.vimPlugins; [
					alpha-nvim
					nvim-autopairs
					nvim-cmp
					cmp-nvim-lsp
					cmp-copilot
					nord-nvim
					nvim-comment
					lspkind-nvim
					gitsigns-nvim
					lualine-nvim
					luasnip
					nvim-lspconfig
					nvim-tree-lua
					null-ls-nvim
					telescope-nvim
					presence-nvim
					spellsitter-nvim
					nvim-treesitter.withAllGrammars
				];
			};
		};
	};
}
