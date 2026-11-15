-- =============================================================================
-- Statusline Configuration
-- =============================================================================

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.api.nvim_set_hl(0, "LualineDiagError", { fg = "#d16d92", bg = "NONE" })
            vim.api.nvim_set_hl(0, "LualineDiagWarn", { fg = "#c4a7e7", bg = "NONE" })
            vim.api.nvim_set_hl(0, "LualineDiagInfo", { fg = "#7daea3", bg = "NONE" })
            vim.api.nvim_set_hl(0, "LualineDiagHint", { fg = "#908caa", bg = "NONE" })

            local lualine_theme = {
                normal = {
                    a = { fg = "#ebbcba", bg = "NONE", gui = "bold" },
                    b = { fg = "#908caa", bg = "NONE" },
                    c = { fg = "#908caa", bg = "NONE" },
                },
                insert = { a = { fg = "#9ccfd8", bg = "NONE", gui = "bold" } },
                visual = { a = { fg = "#c4a7e7", bg = "NONE", gui = "bold" } },
                replace = { a = { fg = "#d16d92", bg = "NONE", gui = "bold" } },
                command = { a = { fg = "#ca9f7c", bg = "NONE", gui = "bold" } },
                inactive = {
                    a = { fg = "#6e6a86", bg = "NONE" },
                    b = { fg = "#6e6a86", bg = "NONE" },
                    c = { fg = "#6e6a86", bg = "NONE" },
                },
            }

            require("lualine").setup({
                options = {
                    theme = lualine_theme,
                    globalstatus = true,
                    component_separators = "",
                    section_separators = "",
                    disabled_filetypes = {
                        statusline = { "help", "qf", "Trouble", "lazy" },
                    },
                    always_divide_middle = false,
                },

                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {
                        "branch",
                        {
                            "diff",
                            symbols = { added = " ", modified = " ", removed = " " },
                            colored = false,
                        }
                    },
                    lualine_c = {
                        {
                            "filename",
                            path = 1,
                            symbols = { modified = " ●", readonly = " ", unnamed = " [No Name]" }
                        },
                    },
                    lualine_x = {
                        {
                            "diagnostics",
                            sources = { 'nvim_lsp' },
                            sections = { 'error', 'warn', 'info', 'hint' },
                            symbols = {
                                error = "●",
                                warn = "●",
                                info = "●",
                                hint = "●",
                            },
                            colored = true,
                            update_in_insert = false,
                        },
                        "filetype",
                    },
                    lualine_y = { "location" },
                    lualine_z = { "progress" },
                },

                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = { "filetype" },
                    lualine_y = {},
                    lualine_z = {},
                },
            })
        end,
    },
}
