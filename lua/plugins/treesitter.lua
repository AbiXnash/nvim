-- Customize Treesitter

---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"java",
			"javascript",
			"html",
			"css",
			"json",
			"markdown",
			"markdown_inline",
			"gitignore",
			-- add more arguments for adding more treesitter parsers
		},

		highlight = {
			enable = true,
		},
	},
}
