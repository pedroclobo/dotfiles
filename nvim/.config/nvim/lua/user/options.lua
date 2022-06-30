local options = {
	autoindent = true,                         -- copy indent from current line on new line
	clipboard = "unnamedplus",                 -- use system clipboard
	colorcolumn = "80",                        -- draw a column at the specified char value
	completeopt = { "menuone", "noselect" },   -- insert mode completion
	cursorline = true,                         -- highlight the text line of the cursor
	fileencoding = "utf-8",                    -- file-content encoding for current buffer
	hlsearch = false,                          -- disable match highlight while searching
	ignorecase = true,                         -- case insensitive search
	number = true,                             -- show current absolute line number
	relativenumber = true,                     -- show the relative line numbers
	scrolloff = 8,                             -- minimal numbers of lines to keep above and below cursor
	shiftwidth = 4,                            -- number of spaces to use after an indent
	showcmd = false,                           -- don't show command in the last line of the screen
	showmode = false,                          -- don't put a message on the last line while in insert or visual modes
	signcolumn = "yes",                        -- draw a left side column
	swapfile = false,                          -- don't use a swapfile for the current buffer
	tabstop = 4,                               -- number of spaces a tab counts for
	termguicolors = true,                      -- enable more colors
	writebackup = false,                       -- don't make backup before overwriting file
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
