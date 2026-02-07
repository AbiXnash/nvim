-- =============================================================================
-- Telescope Configuration
-- =============================================================================
-- Fuzzy finder with fzf integration
-- =============================================================================

local function telescope_setup()
    local telescope = require("telescope")

    telescope.setup({
        defaults = {
            layout_strategy = "vertical",
            layout_config = {
                width = 0.95,
                height = 0.95,

                vertical = {
                    prompt_position = "top",
                    preview_height = 0.55, -- preview at bottom
                    preview_cutoff = 0,
                },
            },

            file_ignore_patterns = { "node_modules", ".git/", "target", "build" },
            path_display = { "smart" },
            sorting_strategy = "ascending",
            winblend = 0,
            border = true,
            previewer = true,
        },
    })
end

local function setup_keymaps()
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Live grep search" })
    vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find git files" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
end

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        telescope_setup()
        setup_keymaps()
    end,
}
