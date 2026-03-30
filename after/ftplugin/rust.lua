local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
    "n",
    "<leader>ca",
    function()
        vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
        -- or vim.lsp.buf.codeAction() if you don't want grouping.
    end,
    { silent = true, buffer = bufnr }
)

vim.keymap.set(
    "n",
    "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    function()
        vim.cmd.RustLsp({ 'hover', 'actions' })
    end,
    { silent = true, buffer = bufnr }
)

vim.api.nvim_create_autocmd("LspAttach", {
    buffer = bufnr,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "rust-analyzer" then
            pcall(require, "virtualtypes")
            local ok, vt = pcall(require, "virtualtypes")
            if ok and vt and vt.on_attach then
                vt.on_attach(client, bufnr)
            end
        end
    end,
})
