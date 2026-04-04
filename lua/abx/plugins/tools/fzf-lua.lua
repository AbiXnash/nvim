-- =============================================================================
-- FZF Lua
-- =============================================================================

return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
        require("fzf-lua").setup({})
        require("fzf-lua").register_ui_select()
    end,
}
