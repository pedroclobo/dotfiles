-- Delete trailing whitespace
vim.api.nvim_create_user_command("Whitespace", function() vim.cmd "%s/\\s\\+$//e" end, {})
