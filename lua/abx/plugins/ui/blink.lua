local C = require("abx.config")

return {
    { "L3MON4D3/LuaSnip", keys = {} },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },

    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        version = "*",
        config = function()
            local blink = require("blink.cmp")

            blink.setup({
                snippets = {
                    preset = "luasnip",
                },
                signature = {
                    enabled = true,
                },
                appearance = {
                    use_nvim_cmp_as_default = false,
                    nerd_font_variant = "normal",
                },
                sources = {
                    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                    providers = {
                        lazydev = {
                            name = "LazyDev",
                            module = "lazydev.integrations.blink",
                            score_offset = 100,
                        },
                        lsp = {
                            name = "LSP",
                            score_offset = 60,
                        },
                        path = {
                            name = "Path",
                            score_offset = 40,
                        },
                        snippets = {
                            name = "Snippets",
                            score_offset = 30,
                        },
                        buffer = {
                            name = "Buffer",
                            score_offset = 10,
                        },
                    },
                },
                completion = {
                    accept = {
                        auto_brackets = {
                            enabled = true,
                        },
                    },
                    menu = {
                        auto_show = true,
                        border = "none",
                        scrollbar = false,
                        winblend = 0,
                        draw = {
                            columns = {
                                { "kind_icon" },
                                { "label", "label_description", gap = 1 },
                            },
                        },
                    },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 0,
                        window = {
                            border = "none",
                            winblend = 0,
                            max_height = 35,
                            max_width = 100,
                        },
                    },
                    ghost_text = {
                        enabled = true,
                    },
                },
                fuzzy = {
                },
                keymap = {
                    preset = "enter",
                    ["<Tab>"] = { "select_next", "fallback" },
                    ["<S-Tab>"] = { "select_prev", "fallback" },
                    ["<C-n>"] = { "select_next", "fallback" },
                    ["<C-p>"] = { "select_prev", "fallback" },
                    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                    ["<C-space>"] = { "show", "fallback" },
                    ["<C-e>"] = { "hide", "fallback" },
                    ["<CR>"] = { "accept", "fallback" },
                    ["<C-j>"] = { "select_next", "fallback" },
                    ["<C-k>"] = { "select_prev", "fallback" },
                },
                cmdline = {
                    enabled = false,
                },
            })

            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
