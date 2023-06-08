local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Leader Key
vim.keymap.set("n", "<space>", "<Nop>", opts)
vim.g.mapleader = " "

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
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Scripts
keymap("n", "<leader><leader>c", ":!compiler % <CR>", {})
keymap("n", "<leader><leader>r", ":!runner % <CR>", {})
keymap("n", "<leader><leader>o", ":!opout % <CR>", {})

-- Telescope
keymap("n", "<leader>s", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>g", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>p", "<cmd>Telescope projects<CR>", opts)
keymap("n", "<leader>b", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>h", "<cmd>Telescope help_tags<CR>", opts)

-- Switch between recent buffers
keymap("n", "<leader><Tab>", "<C-^>", opts)

-- Copy buffer into clipboard
keymap("n", "<leader>y", ":w !xsel -ib<CR><CR>", opts)

-- Delete trailing whitespace
keymap("n", "<leader>d", [[<cmd>%s/\s\+$//e<CR>]], opts)
