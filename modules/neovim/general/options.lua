local options = {
	autoindent = true,
	clipboard = "unnamedplus",
	cmdheight = 0,
	colorcolumn = "80",
	completeopt = { "menuone", "noselect" },
	cursorline = true,
	fileencoding = "utf-8",
	hlsearch = false,
	ignorecase = true,
	number = true,
	relativenumber = true,
	scrolloff = 8,
	shiftwidth = 4,
	showcmd = false,
	showmode = false,
	signcolumn = "yes",
	spelllang = "en_us,pt_pt",
	swapfile = false,
	tabstop = 4,
	termguicolors = true,
	timeoutlen = 500,
	writebackup = false,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd "highlight WinSeparator guibg=None"
