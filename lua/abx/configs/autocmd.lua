vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})

