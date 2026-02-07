-- =============================================================================
-- Web Development Language Support
-- =============================================================================
-- Enhanced support for modern web development with HTMX, HTML5, and frameworks
-- Includes color preview, auto-tagging, and intelligent comment handling
-- =============================================================================

return {
    -- Enhanced color highlighting for web files
    { "brenoprata10/nvim-highlight-colors", opts = {} },

    -- Comprehensive JSON schema store for validation
    { "b0o/schemastore.nvim" },

    -- Auto-close HTML/XML tags - supports HTMX templates
    {
        "windwp/nvim-ts-autotag",
        ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "htmx" },
        config = true,
    },

    -- Context-aware comment strings for mixed-language files
    -- Fixed: Resolved deprecated Treesitter module issues (Jan 2026)
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
            })
            -- Fix Treesitter's deprecated module
            vim.g.skip_ts_context_commentstring_module = true
        end,
    },

    -- Inline color preview for CSS/HTML/HTMX files
    {
        "mrshmllow/document-color.nvim",
        ft = { "css", "scss", "less", "html", "htmx" },
        opts = {
            mode = "foreground",
        },
    },

    -- Tag generation and management for web development
    {
        "c0r73x/neotags.lua",
        ft = { "html", "htmx", "css", "javascript", "typescript" },
        opts = {
            update = true,
            current_buffer_only = false,
        },
    },
}
