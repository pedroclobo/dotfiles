local present, alpha = pcall(require, "alpha")
if not present then return end

local dashboard = require "alpha.themes.dashboard"

dashboard.section.header.val = {
	[[                                                  ]],
	[[███    ██ ███████  ██████  ██    ██ ██ ███    ███ ]],
	[[████   ██ ██      ██    ██ ██    ██ ██ ████  ████ ]],
	[[██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██ ]],
	[[██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██ ]],
	[[██   ████ ███████  ██████    ████   ██ ██      ██ ]],
	[[                                                  ]],
}

dashboard.section.buttons.val = {
	dashboard.button("e", " New file", ":ene <BAR> startinsert<CR>"),
	dashboard.button("s", " Find file", ":Telescope find_files<CR>"),
	dashboard.button("g", " Find text", ":Telescope live_grep<CR>"),
	dashboard.button("h", " Help", ":Telescope help_tags<CR>"),
	dashboard.button("q", " Quit", ":qa<CR>"),
}

local function footer()
	local version = vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
	return "v" .. version
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
