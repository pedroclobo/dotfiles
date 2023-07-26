{ pkgs, config, lib, ... }:

let
	cfg = config.modules.neovim;
	inherit (lib) mkEnableOption mkIf;

	grammars = with pkgs.unstable.vimPlugins.nvim-treesitter.builtGrammars; [
		bash
		c
		comment
		cpp
		html
		java
		javascript
		latex
		lua
		markdown
		nix
		python
		rust
		toml
		typescript
		vim
		yaml
	];

in
{
	options.modules.neovim.enable = mkEnableOption "neovim";

	config = mkIf cfg.enable {
		environment.sessionVariables = {
			EDITOR = "vi";
		};
		hm = {
			programs = {
				neovim = {
					enable = true;
					viAlias = true;
					vimdiffAlias = true;
					extraLuaConfig = builtins.concatStringsSep "\n" [
						(lib.strings.fileContents ./general/keymaps.lua)
						(lib.strings.fileContents ./general/options.lua)
					];
					plugins = with pkgs.unstable.vimPlugins; [
						{
							plugin = alpha-nvim;
							type = "lua";
							config = builtins.readFile ./plugins/alpha.lua;
						}

						{
							plugin = nvim-autopairs;
							type = "lua";
							config = builtins.readFile ./plugins/autopairs.lua;
						}

						{
							plugin = nvim-cmp;
							type = "lua";
							config = builtins.readFile ./plugins/cmp.lua;
						}
						lspkind-nvim
						cmp-nvim-lua
						cmp-nvim-lsp
						cmp-buffer
						cmp-path
						cmp-cmdline
						copilot-cmp

						{
							plugin = comment-nvim;
							type = "lua";
							config = builtins.readFile ./plugins/comment.lua;
						}

						{
							plugin = copilot-lua;
							type = "lua";
							config = builtins.readFile ./plugins/copilot.lua;
						}

						{
							plugin = gitsigns-nvim;
							type = "lua";
							config = builtins.readFile ./plugins/gitsigns.lua;
						}

						{
							plugin = nvim-lspconfig;
							type = "lua";
							config = builtins.readFile ./plugins/lspconfig.lua;
						}
						vim-illuminate

						{
							plugin = lspkind-nvim;
							type = "lua";
							config = builtins.readFile ./plugins/lspkind.lua;
						}

						{
							plugin = lualine-nvim;
							type = "lua";
							config = builtins.readFile ./plugins/lualine.lua;
						}

						{
							plugin = luasnip;
							type = "lua";
							config = builtins.readFile ./plugins/luasnip.lua;
						}

						{
							plugin = nord-nvim;
							type = "lua";
							config = builtins.readFile ./plugins/nord.lua;
						}

						{
							plugin = formatter-nvim;
							type = "lua";
							config = builtins.readFile ./plugins/formatter.lua;
						}

						{
							plugin = nvim-tree-lua;
							type = "lua";
							config = builtins.readFile ./plugins/nvim-tree.lua;
						}

						{
							plugin = telescope-nvim;
							type = "lua";
							config = builtins.readFile ./plugins/telescope.lua;
						}

						{
							plugin = (nvim-treesitter.withPlugins (plugins: grammars));
							type = "lua";
							config = builtins.readFile ./plugins/treesitter.lua;
						}
						nvim-treesitter-textobjects
						nvim-ts-rainbow
						nvim-ts-autotag

						nvim-web-devicons
					];
					extraPackages = with pkgs; [
						# Language Servers
						sumneko-lua-language-server
						rnix-lsp
						rust-analyzer
						nodePackages.pyright
						llvmPackages_9.libclang

						# Linters
						shellcheck

						# Formatters
						rustfmt
						shfmt
						stylua
						yapf

						nodejs_18
						xclip
						ripgrep
					];
				};
			};
		};
	};
}
