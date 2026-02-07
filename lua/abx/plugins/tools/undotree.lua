return {
    "mbbill/undotree",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>U", vim.cmd.UndotreeToggle }
    }
}
