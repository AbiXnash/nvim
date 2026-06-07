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

    -- Strongly guard vim.treesitter.start to prevent the core treesitter highlighter
    -- decoration provider from attaching to buffers that commonly cause crashes
    -- like: "attempt to call method 'range' (a nil value)" in languagetree/highlighter.
    --
    -- This is a frequent issue with Telescope (TelescopePrompt buffers), quickfix,
    -- nofile/prompt buffers, especially on Neovim 0.11/0.12 nightlies.
    if vim.treesitter and vim.treesitter.start then
        local _ts_bad_filetypes = { "^Telescope" }
        local _ts_bad_buftypes = { prompt = true, nofile = true, terminal = true, quickfix = true }

        local _ts_orig_start = vim.treesitter.start
        vim.treesitter.start = function(bufnr, lang)
            bufnr = bufnr or vim.api.nvim_get_current_buf()
            if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
                return
            end
            local ft = vim.bo[bufnr].filetype or ""
            local bt = vim.bo[bufnr].buftype
            for _, pat in ipairs(_ts_bad_filetypes) do
                if ft:match(pat) then
                    return
                end
            end
            if _ts_bad_buftypes[bt] then
                return
            end
            return _ts_orig_start(bufnr, lang)
        end
    end

    treesitter.setup({
        modules = {},
        ignore_install = { "vim" },
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

        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
            },
        },

        additional_vim_regex_highlighting = false,
    })

    -- Extra defense: explicitly stop + clear any treesitter highlights on
    -- Telescope's internal buffers. The early guard in autocmd.lua (wrapping
    -- vim.treesitter.start) should prevent most attachments, but this catches
    -- cases where attachment happened during buffer creation or from other code.
    vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "BufEnter" }, {
        pattern = { "TelescopePrompt", "TelescopeResults", "TelescopePreview" },
        callback = function(ev)
            vim.schedule(function()
                if vim.api.nvim_buf_is_valid(ev.buf) then
                    vim.treesitter.stop(ev.buf)
                    -- Clear the specific highlighter namespace if it exists
                    local ns = vim.api.nvim_get_namespaces()["nvim.treesitter.highlighter"]
                    if ns then
                        vim.api.nvim_buf_clear_namespace(ev.buf, ns, 0, -1)
                    end
                end
            end)
        end,
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    -- Load early so the highlight disable logic and Telescope buffer protections
    -- are active before Telescope (or other plugins) can trigger the highlighter
    -- on special buffers.
    lazy = false,
    build = ":TSUpdate",
    config = treesitter_setup,
}
