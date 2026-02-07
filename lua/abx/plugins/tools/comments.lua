return {
    { "tpope/vim-sleuth", },
    { 'jinh0/eyeliner.nvim',      opts = { highlight_on_key = true, } },
    { "folke/todo-comments.nvim", opts = {} },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                padding = true,
                sticky = true,
                ignore = '^$',
                toggler = {
                    line = 'gcc',
                    block = 'gbc',
                },
                opleader = {
                    line = 'gc',
                    block = 'gb',
                },
                extra = {
                    above = 'gcO',
                    below = 'gco',
                    eol = 'gcA',
                },
                mappings = {
                    basic = true,
                    extra = true,
                },
                pre_hook = function(ctx)
                    local U = require "Comment.utils"
                    local commentstring = vim.bo.commentstring

                    if ctx.ctype == U.ctype.line then
                        return commentstring:gsub("%s*%%s%s*", "")
                    else
                        return commentstring
                    end
                end,
                post_hook = function() end,
            })

            -- Keybindings
            vim.keymap.set("n", "<leader>/", function()
                return require("Comment.api").call(
                    "toggle.linewise." .. (vim.v.count == 0 and "current" or "count_repeat"),
                    "g@$"
                )()
            end, { expr = true, silent = true, desc = "Toggle comment line" })

            vim.keymap.set(
                "x",
                "<leader>/",
                "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>",
                { desc = "Toggle comment (visual)" }
            )
        end,
    },
}
