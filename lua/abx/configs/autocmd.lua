-- =============================================================================
-- Autocommands + Early Guards
-- =============================================================================

-- Strongly guard vim.treesitter.start to prevent the core treesitter highlighter
-- decoration provider from attaching to buffers that commonly cause crashes
-- like: "attempt to call method 'range' (a nil value)" in languagetree/highlighter.
--
-- This is a frequent issue with Telescope (TelescopePrompt buffers), quickfix,
-- nofile/prompt buffers, especially on Neovim 0.11/0.12 nightlies when a parser
-- tree ends up in an invalid state (nil root) during rapid buffer creation or injections.
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
