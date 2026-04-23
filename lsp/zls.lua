local util = require("lspconfig.util")

local function get_zls_config()
    local root_dir = util.root_pattern("build.zig", "zls.json", ".git")()
    root_dir = root_dir or vim.loop.cwd()

    local config = {
        cmd = { "zls" },
        filetypes = { "zig", "zir" },
        root_dir = function()
            return util.root_pattern("build.zig", "zls.json", ".git")() or vim.loop.cwd()
        end,
        single_file_support = true,
        settings = {
            zls = {
                enable_semantic_tokens = true,
                enable_inlay_hints = true,
                enable_snippets = true,
                warn_style = true,
                enable_unused_variable_warnings = true,
                enable_build_on_save = true,
                enable_import_embedfile_argument_completions = true,
                operator_completions = true,
                max_detail_length = 1048576,
            },
        },
    }

    local local_zls = vim.fs.joinpath(root_dir, "zls.json")
    if vim.fn.filereadable(local_zls) == 1 then
        config.cmd = { "zls", "--config-path", local_zls }
    end

    return config
end

return get_zls_config()