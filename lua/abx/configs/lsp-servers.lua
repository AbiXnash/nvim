-- =============================================================================
-- LSP Server Configuration
-- =============================================================================

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

-- Global diagnostic keymaps (work on any buffer)
vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
vim.keymap.set("n", "<leader>d", function()
    vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "Show line diagnostics" })
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })

-- LSP-specific keymaps (only on buffers that have an LSP attached)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
    callback = function(args)
        local bufnr = args.buf
        local key_mappings = {
            { "gr", "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
            { "gD", "<cmd>Telescope lsp_declarations<CR>", "Go to declaration" },
            { "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions" },
            { "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
            { "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
            { "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", "Code actions" },
            { "<leader>rn", vim.lsp.buf.rename, "Smart rename" },
            {
                "K",
                function()
                    vim.lsp.buf.hover({ border = "rounded" })
                end,
                "Show documentation",
            },
        }

        for _, mapping in ipairs(key_mappings) do
            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", mapping[1], mapping[2], vim.tbl_extend("force", opts, { desc = mapping[3] }))
        end
    end,
})
