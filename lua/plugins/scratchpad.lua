return {
	"athar-qadri/scratchpad.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local scratchpad = require "scratchpad"
		scratchpad:setup { settings = { sync_on_ui_close = true } }
	end,
	keys = {
		{
			"<Leader>s",
			"<cmd>Scratch Pad<cr>",
		},
		{
			"<Leader>ss",
			function()
				local scratchpad = require "scratchpad"
				scratchpad.ui:new_scratchpad()
			end,
			desc = "Show scratch pad",
		},
		{
			"<Leader>sp",
			function()
				local scratchpad = require "scratchpad"
				scratchpad.ui:sync()
			end,
			desc = "Push selection / current line to scratchpad",
			mode = { "n", "v" }, -- Specify that this works in normal & visual mode
		},

		desc = "Push selection / current line to scratchpad",
	},
}
