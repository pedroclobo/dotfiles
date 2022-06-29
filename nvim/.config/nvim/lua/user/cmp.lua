local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	vim.notify("Failed to require cmp!")
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	vim.notify("Failed to require luasnip!")
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local icons = require("user.icons")
local kind_icons = icons.kind

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-h>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-l>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-y>"] = cmp.mapping.confirm({ select = false }),
		["<C-e>"] = cmp.mapping.close(),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = kind_icons[vim_item.kind]

			vim_item.menu = ({
				nvim_lsp = "",
				nvim_lua = "",
				luasnip = "",
				buffer = "",
				path = "",
			})[entry.source.name]

			return vim_item
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = false,
	},
})
