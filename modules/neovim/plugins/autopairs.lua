local present, npairs = pcall(require, "nvim-autopairs")
if not present then return end

npairs.setup({
	check_ts = true,
})

-- Better completion and autopairs
local present, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not present then return end

local present, cmp = pcall(require, "cmp")
if not present then return end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
