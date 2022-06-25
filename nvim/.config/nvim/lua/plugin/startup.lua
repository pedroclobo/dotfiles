local status_ok, startup = pcall(require, "startup")
if not status_ok then
	vim.notify("startup is not installed!")
	return
end

startup.setup()
