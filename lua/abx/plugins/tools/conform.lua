-- =============================================================================
-- Conform Formatter Configuration
-- =============================================================================

return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
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
            -- For Java, Kotlin, Groovy, SQL etc. we fall back to LSP
            -- Add more as needed, e.g. "rust" was removed but could add "rustfmt"
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    },
}