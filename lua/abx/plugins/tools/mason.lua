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
                -- Only tools this config actually runs: servers enabled in
                -- plugins/tools/lsp.lua, formatters in conform.lua, and what
                -- nvim-java / kotlin.nvim launch. Add linters here together with
                -- something that runs them (e.g. nvim-lint).
                ensure_installed = {
                    -- Go
                    "gopls",
                    "gofumpt",
                    -- Web
                    "vtsls",
                    "svelte-language-server",
                    "eslint",
                    "html-lsp",
                    "css-lsp",
                    "emmet-ls",
                    "tailwindcss-language-server",
                    "prettierd",
                    -- Python
                    "basedpyright",
                    "black",
                    -- Lua
                    "lua-language-server",
                    "stylua",
                    -- Shell
                    "shfmt",
                    -- JVM
                    "jdtls",
                    "java-test",
                    "java-debug-adapter",
                    "google-java-format",
                    "kotlin-lsp",
                    "ktlint",
                    "gradle-language-server",
                    "groovy-language-server",
                },
            })
        end,
    },
}
