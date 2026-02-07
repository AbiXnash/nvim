-- Development tools
return {
    -- Comments
    { import = "abx.plugins.tools.comments" },
    
    -- Surround
    { import = "abx.plugins.tools.surround" },
    
    -- Fuzzy finder (telescope)
    { import = "abx.plugins.tools.telescope" },

    -- Git integration (gitsigns, fugitive, diffview)
    { import = "abx.plugins.tools.git" },

    -- Code formatters (conform, none-ls)
    -- { import = "abx.plugins.tools.formatters" },

    -- LSP base plugins (lspconfig, nvim-lspconfig)
    -- { import = "abx.plugins.tools.lsp" },

    -- LSP package manager (mason)
    { import = "abx.plugins.tools.mason" },

    -- Syntax highlighting (treesitter)
    { import = "abx.plugins.tools.treesitter" },

    -- Diagnostics panel (trouble)
    { import = "abx.plugins.tools.trouble" },

    -- Undo history (undotree)
    { import = "abx.plugins.tools.undotree" },

    -- Inline diagnostics (tiny-inline-diagnostic)
    { import = "abx.plugins.tools.inline-diagnostics" },

    -- File manager (oil.nvim)
    -- { import = "abx.plugins.tools.oil" },

    -- Quick file navigation (harpoon2)
    { import = "abx.plugins.tools.harpoon" },
}
