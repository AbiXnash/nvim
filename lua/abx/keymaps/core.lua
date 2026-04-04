-- =============================================================================
-- Core Keymaps
-- =============================================================================

local function map(mode, lhs, rhs, opts)
    local default_opts = { noremap = true, silent = true }
    vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend("force", default_opts, opts or {}))
end

local function nmap(lhs, rhs, opts)
    map("n", lhs, rhs, opts)
end

local function imap(lhs, rhs, opts)
    map("i", lhs, rhs, opts)
end

local function vmap(lhs, rhs, opts)
    map("v", lhs, rhs, opts)
end

-- Escape
nmap("<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
imap("jk", "<Esc>", { desc = "Exit insert mode" })
imap("kj", "<Esc>", { desc = "Exit insert mode (alt)" })

-- Clipboard
vmap("<C-c>", '"+y', { desc = "Copy to system clipboard" })

-- File Explorer
nmap("<leader>e", "<cmd>Oil<CR>", { desc = "File explorer (Oil)" })

-- Git
nmap("<leader>g", "<cmd>G<CR>", { desc = "Git status (Fugitive)" })
