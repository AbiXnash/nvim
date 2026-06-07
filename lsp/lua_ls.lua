return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim", "love" },
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.api.nvim_get_runtime_file("", true),
                    vim.fn.expand("~/love2d-types/library"),
                },
            },
            telemetry = {
                enable = false,
            },
            hint = {
                enable = true,
            },
        },
    },
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
}
