return {
    -- Git signs and inline diffs
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "" },
                    topdelete = { text = "" },
                    changedelete = { text = "│" },
                    untracked = { text = "│" },
                },
                on_attach = function(bufnr)
                    local gs = require("gitsigns")

                    local function map(mode, l, r, opts)
                        vim.keymap.set(mode, l, r, vim.tbl_extend("force", { buffer = bufnr }, opts))
                    end

                    map("n", "]c", function()
                        if vim.wo.diff then return "]c" end
                        vim.schedule(function() gs.next_hunk() end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Next hunk" })

                    map("n", "[c", function()
                        if vim.wo.diff then return "[c" end
                        vim.schedule(function() gs.prev_hunk() end)
                        return "<Ignore>"
                    end, { expr = true, desc = "Previous hunk" })

                    map({ "n", "v" }, "<leader>ghs", gs.stage_hunk, { desc = "Stage hunk" })
                    map({ "n", "v" }, "<leader>ghr", gs.reset_hunk, { desc = "Reset hunk" })
                    map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage buffer" })
                    map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                    map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset buffer" })
                    map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview hunk" })
                    map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
                    map("n", "<leader>ghd", gs.diffthis, { desc = "Diff this" })
                    map("n", "<leader>ghD", function() gs.diffthis("~") end, { desc = "Diff this ~" })
                end,
            })
        end,
    },

    -- Git commands and operations
    { "tpope/vim-fugitive" },

    -- Git diff viewer in tabs
    { "sindrets/diffview.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
}
