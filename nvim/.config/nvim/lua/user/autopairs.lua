-- Protected call to nvim-autopairs
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	print("nvim-autopairs not installed!")
	return
end

npairs.setup({
	check_ts = true,
	disable_filetype = { "TelescopePrompt" },
})

-- Better completion and autopairs
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	print("cmp not installed!")
	return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
