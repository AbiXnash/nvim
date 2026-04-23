-- =============================================================================
-- LSP Configuration
-- =============================================================================

local enabled_servers = {
    "lua_ls",
    "gopls",
    "vtsls",
    "zls",
}

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            vim.lsp.enable(enabled_servers)

            local lsp_root = vim.fn.stdpath("config")
            vim.lsp.config.zls = dofile(lsp_root .. "/lsp/zls.lua")

            vim.api.nvim_create_autocmd({ "LspAttach", "BufReadPost" }, {
                pattern = { "*.zig", "*.zir", "*.zon" },
                callback = function(args)
                    local clients = vim.lsp.get_clients({ bufnr = args.buf, name = "zls" })
                    if #clients == 0 then
                        vim.lsp.start(vim.lsp.config.zls, { bufnr = args.buf })
                    end
                end,
            })
        end
    },

    {
        'mrcjkb/rustaceanvim',
        version = '^8',
        lazy = false,
        init = function()
            vim.g.rustaceanvim = {
                inlay_hints = {
                    parameter_hints = { show = true },
                    other_hints = { show = true },
                }
            }
        end
    },

    {
        'nvim-java/nvim-java',
        config = function()
            require('java').setup()
            vim.lsp.enable('jdtls')
        end,
    },

    {
        "AlexandrosAlexiou/kotlin.nvim",
        ft = { "kotlin" },
        dependencies = {
            "mason.nvim",
            "mason-lspconfig.nvim",
            "oil.nvim",
            "trouble.nvim",
        },
        config = function()
            require("kotlin").setup {
                root_markers = {
                    "gradlew",
                    ".git",
                    "mvnw",
                    "settings.gradle",
                },
                jre_path = nil,
                jdk_for_symbol_resolution = nil,
                jvm_args = {
                    "-Xmx4g",
                },
                inlay_hints = {
                    enabled = true,
                    parameters = true,
                    parameters_compiled = true,
                    parameters_excluded = false,
                    types_property = true,
                    types_variable = true,
                    function_return = true,
                    function_parameter = true,
                    lambda_return = true,
                    lambda_receivers_parameters = true,
                    value_ranges = true,
                    kotlin_time = true,
                },
            }
        end,
    },

}
