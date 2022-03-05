local g = vim.g
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Leader Key
g.mapleader = " "

-- Window navegation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Explorer
keymap("n", "<leader>e", ":Lex 10<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Scripts
keymap("n", "<leader>c", ":!compiler % <CR>", {})
keymap("n", "<leader>r", ":!runner % <CR>", {})

-- Telescope
keymap("n", "<leader>s", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>", opts)

-- Nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Format
keymap("n", "<leader>f", ":lua vim.lsp.buf.formatting_sync()<CR>", opts)
