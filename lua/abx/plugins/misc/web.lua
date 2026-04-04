-- =============================================================================
-- Web Development Plugins
-- =============================================================================

return {
    { "brenoprata10/nvim-highlight-colors", opts = {} },
    { "b0o/schemastore.nvim" },
    {
        "windwp/nvim-ts-autotag",
        ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "htmx" },
        config = true,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
            })
            vim.g.skip_ts_context_commentstring_module = true
        end,
    },
    {
        "mrshmllow/document-color.nvim",
        ft = { "css", "scss", "less", "html", "htmx" },
        opts = {
            mode = "foreground",
        },
    },
    {
        "c0r73x/neotags.lua",
        ft = { "html", "htmx", "css", "javascript", "typescript" },
        opts = {
            update = true,
            current_buffer_only = false,
        },
    },
}
