-- Directory tsserver should load typescript-svelte-plugin from: the project's
-- own install if it has one, else the copy Mason ships with svelte-language-server.
-- tsserver resolves the plugin as <location>/node_modules/<name>.
local function svelte_plugin_location(root)
    local candidates = {}
    if root then
        table.insert(candidates, root)
    end
    table.insert(candidates, vim.fn.stdpath("data") .. "/mason/packages/svelte-language-server")
    for _, dir in ipairs(candidates) do
        if vim.uv.fs_stat(dir .. "/node_modules/typescript-svelte-plugin") then
            return dir
        end
    end
end

local lang_settings = {
    updateImportsOnFileMove = "always",
    suggest = {
        completeFunctionCalls = true,
        autoImports = true,
    },
    inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = true },
    },
}

return {
    cmd = { "vtsls", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
    -- No root_dir here: nvim-lspconfig's root_dir function resolves the project
    -- per buffer. (A `vim.fs.root(0, ...)` value was computed once at startup.)

    -- Runs as each client starts, so the plugin is looked up in that client's project.
    before_init = function(_, config)
        local location = svelte_plugin_location(config.root_dir)
        if not location then
            return
        end
        config.settings.vtsls = vim.tbl_deep_extend("force", config.settings.vtsls or {}, {
            tsserver = {
                globalPlugins = {
                    {
                        name = "typescript-svelte-plugin",
                        location = location,
                        languages = { "svelte" },
                        enableForWorkspaceTypeScriptVersions = true,
                    },
                },
            },
        })
    end,
    settings = {
        typescript = vim.deepcopy(lang_settings),
        javascript = vim.deepcopy(lang_settings),
    },
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
}
