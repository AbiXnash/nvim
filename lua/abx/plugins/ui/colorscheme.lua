-- =============================================================================
-- Colorscheme: Hell Pine (github.com/abxengg/hell-pine.nvim), the Neovim port of the Hell Pine VS Code theme
-- =============================================================================

return {
    {
        "abxengg/hell-pine.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("hell-pine").setup({
                -- Ghostty and WezTerm are translucent: let them show through, as the old setup did.
                transparent = true,
            })
            vim.cmd.colorscheme("hell-pine")
        end,
    },
}
