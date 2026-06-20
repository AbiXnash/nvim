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
                    "svelte-language-server",
                    "prettierd",
                    "eslint_d",
                    "eslint",
                    "html-lsp",
                    "css-lsp",
                    "emmet-ls",
                    "tailwindcss-language-server",
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
                    "gradle-language-server",
                    "groovy-language-server",
                },
            })
        end,
    },
}
