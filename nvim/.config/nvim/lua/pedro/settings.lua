-- Settings
vim.opt.autoindent = true          -- copy indent from current line on new line
vim.opt.clipboard = "unnamedplus"  -- use system clipboard for all operations
vim.opt.colorcolumn = "80"         -- draw a column at the specified char value
vim.opt.encoding = "utf-8"         -- encoding for RPC communication
vim.opt.expandtab = false          -- use tabs instead of spaces
vim.opt.fileencoding = "utf-8"     -- file-content encoding for current buffer
vim.opt.hlsearch = false           -- disable match highlight while searching
vim.opt.number = true              -- show current absolute line number
vim.opt.relativenumber = true      -- show the relative line numbers
vim.opt.scrolloff = 8              -- minimal numbers of lines to keep above and below cursor
vim.opt.shiftwidth = 4             -- number of spaces to after an indent
vim.opt.showmode = false           -- don't put a message on the last line while in insert or visual modes
vim.opt.signcolumn = "yes"         -- draw a left side column
vim.opt.swapfile = false           -- don't use a swapfile for the current buffer
vim.opt.tabstop = 4                -- number of spaces a tab counts for

-- Keyboard Mappings
vim.g.mapleader = ' '
vim.api.nvim_set_keymap("n", "<leader>c", ":!compiler % <CR>", {})
vim.api.nvim_set_keymap("n", "<leader>r", ":!runner % <CR>", {})

-- Miscellaneous
vim.cmd [[autocmd BufWritePost * silent! %s/\s\+$//e]]   -- remove trailing white space on file write
vim.cmd "colorscheme nord"
