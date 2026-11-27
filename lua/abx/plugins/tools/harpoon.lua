-- =============================================================================
-- Harpoon2
-- =============================================================================

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({})

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end)
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
        vim.keymap.set("n", "<leader>h", function()
            harpoon:list():select(1)
        end)
        vim.keymap.set("n", "<leader>j", function()
            harpoon:list():select(2)
        end)
        vim.keymap.set("n", "<leader>k", function()
            harpoon:list():select(3)
        end)
        vim.keymap.set("n", "<leader>l", function()
            harpoon:list():select(4)
        end)
        vim.keymap.set("n", "<leader>;", function()
            harpoon:list():select(5)
        end)

        -- Not <C-[>: terminals send it as <Esc>, so it never reached Harpoon.
        vim.keymap.set("n", "<C-p>", function()
            harpoon:list():prev()
        end, { desc = "Harpoon: previous file" })
        vim.keymap.set("n", "<C-n>", function()
            harpoon:list():next()
        end, { desc = "Harpoon: next file" })
    end,
}
