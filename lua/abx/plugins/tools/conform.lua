-- =============================================================================
-- Conform Formatter Configuration
-- =============================================================================

return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        -- Format on save, but respect global/buffer toggle
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_fallback = true }
        end,

        formatters_by_ft = {
            lua = { "stylua" },
            go = { "gofumpt" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescriptreact = { "prettierd" },
            python = { "black" },
            sh = { "shfmt" },
            bash = { "shfmt" },
            java = { "google-java-format" },
            kotlin = { "ktlint" },
            -- groovy = { "npm_groovy_lint" }, -- uncomment if installed (falls back to LSP otherwise)
            -- other JVM: sql, etc. via LSP
            -- Add more as needed
        },
    },

    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = { "n", "v" },
            desc = "Format (conform)",
        },
        {
            "<leader>tf",
            function()
                vim.g.disable_autoformat = not vim.g.disable_autoformat
                vim.notify("Autoformat " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
            end,
            desc = "Toggle autoformat (global)",
        },
        {
            "<leader>tF",
            function()
                local bufnr = vim.api.nvim_get_current_buf()
                vim.b[bufnr].disable_autoformat = not vim.b[bufnr].disable_autoformat
                vim.notify("Buffer autoformat " .. (vim.b[bufnr].disable_autoformat and "disabled" or "enabled"))
            end,
            desc = "Toggle autoformat (buffer)",
        },
    },
}