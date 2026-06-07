-- =============================================================================
-- LSP Server Configuration
-- =============================================================================

local border = {
    { "┌", "FloatBorder" },
    { "─", "FloatBorder" },
    { "┐", "FloatBorder" },
    { "│", "FloatBorder" },
    { "┘", "FloatBorder" },
    { "─", "FloatBorder" },
    { "└", "FloatBorder" },
    { "│", "FloatBorder" },
}

vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})

local key_mappings = {
    { "gr", "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
    { "gD", "<cmd>Telescope lsp_declarations<CR>", "Go to declaration" },
    { "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions" },
    { "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
    { "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
    { "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", "Code actions" },
    { "<leader>rn", vim.lsp.buf.rename, "Smart rename" },
    { "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics" },
    {
        "<leader>d",
        function()
            vim.diagnostic.open_float({ border = "rounded" })
        end,
        "Show line diagnostics",
    },
    {
        "[d",
        function()
            vim.diagnostic.jump({ count = -1, float = true })
        end,
        "Go to previous diagnostic",
    },
    {
        "]d",
        function()
            vim.diagnostic.jump({ count = 1, float = true })
        end,
        "Go to next diagnostic",
    },
    {
        "K",
        function()
            vim.lsp.buf.hover({ border = border })
        end,
        "Show documentation",
    },
    { "<leader>rs", ":LspRestart<CR>", "Restart LSP" },
}

for _, mapping in ipairs(key_mappings) do
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", mapping[1], mapping[2], vim.tbl_extend("force", opts, { desc = mapping[3] }))
end
