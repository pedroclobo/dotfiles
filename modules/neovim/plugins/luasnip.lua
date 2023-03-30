local ls = require "luasnip"

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})

-- Expand and jump snippet
vim.keymap.set({ "i", "s" }, "<C-l>", function()
	if ls.expand_or_jumpable() then ls.expand_or_jump() end
end, { silent = true })

-- Jump backwards on snippet
vim.keymap.set({ "i", "s" }, "<C-h>", function()
	if ls.jumpable(-1) then ls.jump(-1) end
end, { silent = true })
