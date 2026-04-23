-- =============================================================================
-- Mason Package Manager
-- =============================================================================

return {
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "gopls",
                    "gofumpt",
                    "golangci-lint",
                    "delve",
                    "vtsls",
                    "prettierd",
                    "eslint_d",
                    "html-lsp",
                    "basedpyright",
                    "black",
                    "debugpy",
                    "lua-language-server",
                    "stylua",
                    "jdtls",
                    "java-test",
                    "java-debug-adapter",
                    "google-java-format",
                    "checkstyle",
                    "kotlin-language-server",
                    "ktlint",
                    "sqlls",
                    "markdownlint",
                    "marksman",
                    "shellcheck",
                    "shfmt",
                    "lemminx",
                    "zls",
                },
            })
        end,
    },
}
