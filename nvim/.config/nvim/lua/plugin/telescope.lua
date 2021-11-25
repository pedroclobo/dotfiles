local api = vim.api

-- Keymaps
api.nvim_set_keymap("n", "<leader>sf", ":lua require('telescope.builtin').git_files()<CR>", { silent = true });
api.nvim_set_keymap("n", "<leader>sg", ":lua require('telescope.builtin').live_grep()<CR>", { silent = true });
api.nvim_set_keymap("n", "<leader>sb", ":lua require('telescope.builtin').file_browser()<CR>", { silent = true });
