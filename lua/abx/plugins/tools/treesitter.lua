-- =============================================================================
-- Treesitter Configuration
-- =============================================================================

local function treesitter_setup()
    local treesitter = require("nvim-treesitter.configs")

    -- Disable problematic vim-language injections (only affects vim/help buffers).
    -- Using FileType autocmd + pcall to avoid global side effects at startup.
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "vim", "help" },
        callback = function()
            pcall(vim.treesitter.query.set, "vim", "injections", "")
        end,
    })

    -- vim.treesitter.start is guarded once, in abx/configs/treesitter-guard.lua.

    treesitter.setup({
        ensure_installed = {
            "lua",
            "go",
            "typescript",
            "javascript",
            "python",
            "json",
            "html",
            "css",
            "markdown",
            "tsx",
            "svelte",
            "kotlin",
            "java",
            "groovy",
        },
        sync_install = false,
        auto_install = true,

        highlight = {
            enable = true,
            disable = function(_, buf)
                if not buf or not vim.api.nvim_buf_is_valid(buf) then
                    return true
                end

                local buftype = vim.bo[buf].buftype
                if buftype == "prompt" or buftype == "nofile" or buftype == "terminal" then
                    return true
                end

                local ft = vim.bo[buf].filetype or ""
                if ft:match("^Telescope") then
                    return true
                end

                local name = vim.api.nvim_buf_get_name(buf)
                if name == "" then
                    return true
                end

                local ok, stats = pcall(vim.uv.fs_stat, name)
                if ok and stats and stats.size > (100 * 1024) then
                    return true
                end
            end,
        },

        indent = {
            enable = true,
            disable = {},
        },

        -- The textobjects module is not enabled here: its master-branch code
        -- errors on Neovim 0.12. af/if/ac/ic come from mini.ai (see below).

        additional_vim_regex_highlighting = false,
    })
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        -- Load early so the highlight disable logic and Telescope buffer protections
        -- are active before Telescope (or other plugins) can trigger the highlighter
        -- on special buffers.
        lazy = false,
        build = ":TSUpdate",
        config = treesitter_setup,
    },

    -- Function/class text objects: mini.ai runs the @function/@class queries
    -- that nvim-treesitter-textobjects ships (installed only for those queries).
    {
        "echasnovski/mini.ai",
        version = "*",
        event = "VeryLazy",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
        },
        config = function()
            local ai = require("mini.ai")
            -- use_nvim_treesitter = false (also mini.ai's default): query with
            -- Neovim's own API rather than nvim-treesitter master's helpers.
            local ts = function(a, i)
                return ai.gen_spec.treesitter({ a = a, i = i }, { use_nvim_treesitter = false })
            end
            ai.setup({
                custom_textobjects = {
                    f = ts("@function.outer", "@function.inner"),
                    c = ts("@class.outer", "@class.inner"),
                },
            })
        end,
    },
}
