return {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum", "tmpl" },
    root_markers = { "go.mod", "go.work", ".git" },
    settings = {
        gopls = {
            -- Use gofumpt for formatting
            gofumpt = true,

            -- Code lens for common operations
            codelenses = {
                gc_details = true,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },

            -- Inlay hints configuration
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },

            -- Static analysis
            analyses = {
                -- Core analysis rules
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
                unreachable = true,
                staticcheck = true,
                shadow = true,

                -- Style checks
                stylecheck = true,
            },

            -- Completion settings
            usePlaceholders = true,
            completeUnimported = true,

            -- Directory filtering
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-node_modules" },

            -- Semantic tokens for enhanced syntax highlighting
            semanticTokens = true,
        },
    },
}
