local pairs = require "nvim-autopairs"

pairs.setup({
	check_ts = true,
})

-- Better completion and autopairs
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp = require "cmp"
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
