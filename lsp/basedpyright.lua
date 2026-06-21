local python = require("abx.configs.python")

return {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyrightconfig.json",
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "manage.py",
        ".git",
    },
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
                autoImportCompletions = true,
                inlayHints = {
                    variableTypes = true,
                    callArgumentNames = true,
                    functionReturnTypes = true,
                    genericTypes = true,
                    parameterTypes = true,
                },
                diagnosticSeverityOverrides = {
                    reportMissingImports = "warning",
                    reportMissingTypeStubs = "none",
                    reportMissingModuleSource = "none",
                    reportAttributeAccessIssue = "none",
                    reportUnknownMemberType = "none",
                    reportUnknownArgumentType = "none",
                    reportUnknownVariableType = "none",
                    reportUnknownParameterType = "none",
                    reportGeneralTypeIssues = "warning",
                    reportOptionalMemberAccess = "none",
                    reportOptionalSubscript = "none",
                    reportPrivateImportUsage = "none",
                },
            },
        },
    },
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        python.apply_to_basedpyright(client, bufnr)

        if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
            client.request("workspace/executeCommand", {
                command = "basedpyright.organizeimports",
                arguments = { vim.uri_from_bufnr(bufnr) },
            }, nil, bufnr)
        end, { desc = "Organize imports" })
    end,
}
