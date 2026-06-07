-- =============================================================================
-- Conform Formatter Configuration
-- =============================================================================

return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        -- Format on save, but respect buffer-local toggle
        format_on_save = function(bufnr)
            if vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_fallback = true }
        end,

        formatters_by_ft = {
            lua = { "stylua" },
            go = { "gofumpt" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescriptreact = { "prettierd" },
            python = { "black" },
            sh = { "shfmt" },
            bash = { "shfmt" },
            java = { "google-java-format" },
            kotlin = { "ktlint" },
            -- groovy = { "npm_groovy_lint" }, -- uncomment if installed (falls back to LSP otherwise)
            -- other JVM: sql, etc. via LSP
            -- Add more as needed
        },
    },

    keys = {
        {
            "<leader>cf",
            function()
                local conform = require("conform")
                conform.format({
                    async = true,
                    lsp_fallback = true,
                }, function(err, did_edit)
                    if err then
                        vim.notify("Format error: " .. err, vim.log.levels.ERROR)
                    elseif did_edit then
                        local formatters = conform.list_formatters(0)
                        local names = {}
                        for _, f in ipairs(formatters) do
                            if f.available then
                                table.insert(names, f.name)
                            end
                        end
                        local msg = #names > 0 and table.concat(names, ", ") or "LSP"
                        vim.notify("Formatted with: " .. msg)
                    end
                end)
            end,
            mode = { "n", "v" },
            desc = "Format (conform)",
        },
        {
            "<leader>tF",
            function()
                local bufnr = vim.api.nvim_get_current_buf()
                vim.b[bufnr].disable_autoformat = not vim.b[bufnr].disable_autoformat
                vim.notify("Buffer autoformat " .. (vim.b[bufnr].disable_autoformat and "disabled" or "enabled"))
            end,
            desc = "Toggle autoformat (buffer)",
        },
    },
}