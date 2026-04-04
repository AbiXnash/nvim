-- =============================================================================
-- Configuration
-- =============================================================================

local Config = {}

Config.keymaps = {
    window_nav = {
        left = "<C-h>",
        right = "<C-l>",
        down = "<C-j>",
        up = "<C-k>",
    },
    scroll_center = {
        page_down = "<C-d>",
        page_up = "<C-u>",
    },
    lsp_prefix = "<leader>",
}

return Config
