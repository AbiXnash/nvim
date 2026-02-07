-- =============================================================================
-- Editor Keymaps
-- =============================================================================

local function map(mode, lhs, rhs, opts)
    local default_opts = { noremap = true, silent = true }
    vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend("force", default_opts, opts or {}))
end

local function vmap(lhs, rhs, opts)
    map("v", lhs, rhs, opts)
end

-- =============================================================================
-- Line Movement (Visual Mode)
-- =============================================================================
vmap(",", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vmap(".", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
