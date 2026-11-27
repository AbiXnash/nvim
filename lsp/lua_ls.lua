local love_types = vim.fn.expand("~/love2d-types/library")

--- A LÖVE game has main.lua or conf.lua at its root.
local function is_love_project(root)
    return root ~= nil
        and (vim.uv.fs_stat(root .. "/main.lua") ~= nil or vim.uv.fs_stat(root .. "/conf.lua") ~= nil)
end

return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
                -- Neovim's runtime and plugin types come from lazydev.nvim, which
                -- adds only what a file actually requires instead of every runtime file.
                library = {},
            },
            telemetry = {
                enable = false,
            },
            hint = {
                enable = true,
            },
        },
    },
    -- LÖVE types (which also define the `love` global) only for LÖVE projects.
    before_init = function(_, config)
        if is_love_project(config.root_dir) and vim.uv.fs_stat(love_types) then
            -- Copy rather than insert, so the shared settings table never accumulates it.
            local workspace = config.settings.Lua.workspace
            workspace.library = vim.list_extend(vim.deepcopy(workspace.library or {}), { love_types })
        end
    end,
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
}
