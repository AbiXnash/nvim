local script = vim.fn.expand("~/dev/scripts/tmux-sessionizer.sh")

local function sessionizer()
    if vim.fn.executable("tmux") == 0 then
        vim.notify("tmux not found", vim.log.levels.ERROR)
        return
    end

    if vim.fn.filereadable(script) ~= 1 then
        vim.notify("tmux sessionizer script not found: " .. script, vim.log.levels.ERROR)
        return
    end

    if vim.env.TMUX then
        vim.cmd(("silent !tmux neww %s"):format(vim.fn.shellescape(script)))
        return
    end

    vim.cmd(("silent !%s"):format(vim.fn.shellescape(script)))
end

vim.keymap.set("n", "<C-f>", sessionizer, { desc = "Tmux sessionizer" })
