local colorscheme = "nord"

local present, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not present then return end
