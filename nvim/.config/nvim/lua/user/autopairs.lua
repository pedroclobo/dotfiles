local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	vim.notify("Failed to require nvim-autopairs!")
	return
end

npairs.setup({
	check_ts = true,
})

-- Better completion and autopairs
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	vim.notify("Failed to require cmp!")
	return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
