return {
    root_markers = { "Cargo.toml", "Cargo.lock" },
    filetypes = { "rust" },
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
            },
            diagnostics = {
                enable = true,
                experimental = {
                    enable = true,
                },
            },
        },
    },
}
