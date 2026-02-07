return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.api.nvim_set_hl(0, "LualineDiagError", { fg = "#f38ba8", bg = "NONE" })
            vim.api.nvim_set_hl(0, "LualineDiagWarn", { fg = "#f9e2af", bg = "NONE" })
            vim.api.nvim_set_hl(0, "LualineDiagInfo", { fg = "#89dceb", bg = "NONE" })
            vim.api.nvim_set_hl(0, "LualineDiagHint", { fg = "#6c7086", bg = "NONE" })

            local catppuccin = {
                normal = {
                    a = { fg = "#cdd6f4", bg = "NONE", gui = "bold" },
                    b = { fg = "#a6adc8", bg = "NONE" },
                    c = { fg = "#a6adc8", bg = "NONE" },
                },
                insert = { a = { fg = "#a6e3a1", bg = "NONE", gui = "bold" } },
                visual = { a = { fg = "#f9e2af", bg = "NONE", gui = "bold" } },
                replace = { a = { fg = "#f38ba8", bg = "NONE", gui = "bold" } },
                command = { a = { fg = "#fab387", bg = "NONE", gui = "bold" } },
                inactive = {
                    a = { fg = "#6c7086", bg = "NONE" },
                    b = { fg = "#6c7086", bg = "NONE" },
                    c = { fg = "#6c7086", bg = "NONE" },
                },
            }

            require("lualine").setup({
                options = {
                    theme = catppuccin,
                    globalstatus = true,
                    component_separators = "",
                    section_separators = "",
                    disabled_filetypes = {
                        statusline = { "NvimTree", "help", "qf", "Trouble", "lazy" },
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
                            colored = false,
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
