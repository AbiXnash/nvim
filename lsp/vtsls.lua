local function find_svelte_plugin()
    local candidates = {
        vim.fn.stdpath("data")
            .. "/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin",
    }
    local root = vim.fs.root(0, { "package.json", "tsconfig.json", ".git" })
    if root then
        table.insert(candidates, 1, root .. "/node_modules/typescript-svelte-plugin")
    end
    for _, path in ipairs(candidates) do
        if vim.uv.fs_stat(path) then
            return path
        end
    end
end

local plugins = {}
local svelte_plugin_path = find_svelte_plugin()
if svelte_plugin_path then
    table.insert(plugins, {
        name = "typescript-svelte-plugin",
        location = svelte_plugin_path,
        languages = { "svelte" },
    })
end

return {
    cmd = { "vtsls", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
    root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }),
    settings = {
        typescript = {
            tsserverPluginPaths = plugins,
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
        },
        javascript = {
            tsserverPluginPaths = plugins,
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
        },
    },
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
    end,
}
