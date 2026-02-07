-- =============================================================================
-- Harpoon2 Plugin Configuration
-- =============================================================================
-- Quick file navigation with marked files
-- =============================================================================

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({})
		-- basic telescope configuration
		local conf = require("telescope.config").values

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
		vim.keymap.set("n", "<leader>h", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<leader>j", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<leader>k", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<leader>l", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-[>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-]>", function()
			harpoon:list():next()
		end)
	end,
}
