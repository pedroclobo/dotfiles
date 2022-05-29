local cmd = vim.cmd
local opt = vim.opt

-- Settings
opt.autoindent = true                       -- copy indent from current line on new line
opt.backup = false                          -- don't create backup files
opt.clipboard = "unnamedplus"               -- use system clipboard for all operations
opt.colorcolumn = "80"                      -- draw a column at the specified char value
opt.completeopt = { "menuone", "noselect" } -- insert mode completion
opt.conceallevel = 0                        -- show text normally
opt.cursorline = true                       -- highlight the text line of the cursor
opt.encoding = "utf-8"                      -- encoding for RPC communication
opt.expandtab = false                       -- use tabs instead of spaces
opt.fileencoding = "utf-8"                  -- file-content encoding for current buffer
opt.hlsearch = false                        -- disable match highlight while searching
opt.ignorecase = true                       -- case insensitive search
opt.number = true                           -- show current absolute line number
opt.relativenumber = true                   -- show the relative line numbers
opt.scrolloff = 8                           -- minimal numbers of lines to keep above and below cursor
opt.shiftwidth = 4                          -- number of spaces to after an indent
opt.showcmd = false                         -- don't show command in the last line of the screen
opt.showmode = false                        -- don't put a message on the last line while in insert or visual modes
opt.signcolumn = "yes"                      -- draw a left side column
opt.swapfile = false                        -- don't use a swapfile for the current buffer
opt.tabstop = 4                             -- number of spaces a tab counts for
opt.termguicolors = true                    -- enable more colors
opt.writebackup = false                     -- don't make backup before overwriting file

-- Miscellaneous
cmd [[autocmd BufWritePost * silent! %s/\s\+$//e]]   -- remove trailing white space on file write
cmd [[colorscheme nord]]

vim.api.nvim_exec([[ autocmd FileType python setlocal tabstop=4 noexpandtab ]], false)
