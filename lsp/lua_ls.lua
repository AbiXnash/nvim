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
            format = {
                enable = true,
                indentStyle = "space",
                indentSize = "4",
            },
        },
    },
}
