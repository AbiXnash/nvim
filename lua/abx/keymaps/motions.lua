-- =============================================================================
-- Movement Keymaps
-- =============================================================================

local C = require("abx.config")

local function map(mode, lhs, rhs, opts)
    local default_opts = { noremap = true, silent = true }
    vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend("force", default_opts, opts or {}))
end

local function nmap(lhs, rhs, opts)
    map("n", lhs, rhs, opts)
end

-- =============================================================================
-- Window Navigation
-- =============================================================================
nmap(C.keymaps.window_nav.left, "<C-w>h", { desc = "Window left" })
nmap(C.keymaps.window_nav.right, "<C-w>l", { desc = "Window right" })
nmap(C.keymaps.window_nav.down, "<C-w>j", { desc = "Window down" })
nmap(C.keymaps.window_nav.up, "<C-w>k", { desc = "Window up" })

-- =============================================================================
-- Centered Scrolling
-- =============================================================================
nmap(C.keymaps.scroll_center.page_down, "<C-d>zz", { desc = "Page down and center" })
nmap(C.keymaps.scroll_center.page_up, "<C-u>zz", { desc = "Page up and center" })
nmap("n", "nzzzv", { desc = "Next search result and center" })
nmap("N", "Nzzzv", { desc = "Previous search result and center" })
