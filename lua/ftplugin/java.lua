local config = {
	cmd = { vim.fn.expand "~/AppData/Local/nvim-data/mason/bin/jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]), -- Removed extra comma
}
require("jdtls").start_or_attach(config)
