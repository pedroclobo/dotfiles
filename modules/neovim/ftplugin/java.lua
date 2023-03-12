local present, jdtls = pcall(require, "jdtls")
if not present then return end

local JDTLS_LOCATION = vim.fn.stdpath "data" .. "/mason/bin/jdtls"
local config = {
	cmd = { JDTLS_LOCATION },
	root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
}
jdtls.start_or_attach(config)
