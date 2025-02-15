return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional, for icons
	config = function()
		local fzf = require "fzf-lua"

		fzf.setup {
			winopts = {
				height = 0.85, -- Adjust height of the popup
				width = 0.80, -- Adjust width of the popup
				preview = {
					layout = "vertical", -- Vertical preview window
					flip_columns = 120, -- Flip preview layout when window is too narrow
				},
			},
		}
	end,
	keys = {
		{ "<Leader>z", "<cmd>Fuzzy Finder<cr>" },
		{ "<Leader>zf", function() require("fzf-lua").files() end, desc = "Find Files" },
		{ "<Leader>zg", function() require("fzf-lua").live_grep() end, desc = "Live Grep" },
		{ "<Leader>zb", function() require("fzf-lua").buffers() end, desc = "Find Buffers" },
		{ "<Leader>zh", function() require("fzf-lua").help_tags() end, desc = "Find Help Tags" },
	},
}
