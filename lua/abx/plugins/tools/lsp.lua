-- =============================================================================
-- LSP Configuration
-- =============================================================================

local enabled_servers = {
    "lua_ls",
    "gopls",
    "vtsls",
    "svelte",
    "eslint",
    "tailwindcss",
    "emmet_ls",
    "html",
    "cssls",
    "basedpyright",
    "gradle_ls",
    "groovyls",
}

return {
    {
        "neovim/nvim-lspconfig",
        -- Mason first, so its bin directory is on PATH before servers start.
        dependencies = { "mason-org/mason.nvim" },
        config = function()
            -- nvim-lspconfig's lsp/*.lua files come later on the runtimepath than
            -- ours, so on a plain merge its hooks and values replace ours. Apply
            -- every file in our lsp/ explicitly (explicit config wins), and keep
            -- both sides' hooks: lspconfig's runs first, ours after it.
            local hooks = { "on_attach", "on_init", "before_init" }
            local config_lsp = vim.fn.stdpath("config") .. "/lsp"

            for file, kind in vim.fs.dir(config_lsp) do
                local server = kind == "file" and file:match("^(.+)%.lua$")
                if server then
                    local mine = dofile(config_lsp .. "/" .. file)
                    local upstream
                    for _, path in ipairs(vim.api.nvim_get_runtime_file("lsp/" .. file, true)) do
                        if not vim.startswith(path, config_lsp) then
                            upstream = dofile(path)
                            break
                        end
                    end
                    for _, hook in ipairs(hooks) do
                        if mine[hook] and upstream and upstream[hook] then
                            mine[hook] = vim.list_extend(
                                vim.islist(upstream[hook]) and vim.list_slice(upstream[hook]) or { upstream[hook] },
                                vim.islist(mine[hook]) and mine[hook] or { mine[hook] }
                            )
                        end
                    end
                    vim.lsp.config(server, mine)
                end
            end

            vim.lsp.enable(enabled_servers)
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
