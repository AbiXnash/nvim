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
                    -- go
                    "gopls",
                    "gofumpt",
                    "golangci-lint",
                    "delve",

                    -- web (typescript/javascript/html/css/yaml/json)
                    "vtsls",
                    "prettierd",
                    "eslint_d",
                    "html-lsp",
                    -- "yaml-language-server",
                    -- "json-lsp",

                    -- frameworks
                    -- "svelte-language-server",
                    -- "astro-language-server",

                    -- python
                    "basedpyright",
                    "black",
                    "debugpy",

                    -- lua
                    "lua-language-server",
                    "stylua",

                    -- rust
                    -- "rust-analyzer",
                    -- "rustfmt",

                    -- java
                    "jdtls",
                    "java-test",
                    "java-debug-adapter",
                    "google-java-format",
                    "checkstyle",

                    -- kotlin
                    "kotlin-language-server",
                    "ktlint",

                    -- other
                    "sqlls",
                    "markdownlint",
                    "marksman",
                    "shellcheck",
                    "shfmt",
                    "lemminx",
                },
            })
        end,
    },
}
