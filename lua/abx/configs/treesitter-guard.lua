local M = {}

M.bad_filetype_patterns = {
    "^Telescope",
    "^help",
    "^markdown",
    "^qf",
    "^trouble",
    "^oil",
    "^dap",
    "^lazy",
    "^mason",
    "^Dressing",
    "^snacks",
    "^noice",
    "^alpha",
    "^dashboard",
}

M.bad_buftypes = {
    prompt = true,
    nofile = true,
    terminal = true,
    quickfix = true,
    popup = true,
    acwrite = true,
}

function M.should_skip(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
        return true
    end

    local ft = vim.bo[bufnr].filetype or ""
    for _, pat in ipairs(M.bad_filetype_patterns) do
        if ft:match(pat) then
            return true
        end
    end

    return M.bad_buftypes[vim.bo[bufnr].buftype] == true
end

local function empty_range6()
    return { 0, 0, 0, 0, 0, 0 }
end

if vim.treesitter then
    if vim.treesitter.get_range then
        local _orig_get_range = vim.treesitter.get_range
        vim.treesitter.get_range = function(node, source, metadata)
            if node == nil then
                return empty_range6()
            end
            local ok, result = pcall(_orig_get_range, node, source, metadata)
            if ok then
                return result
            end
            return empty_range6()
        end
    end

    if vim.treesitter.start then
        local _orig_start = vim.treesitter.start
        vim.treesitter.start = function(bufnr, lang)
            if M.should_skip(bufnr) then
                return
            end
            local ok, result = pcall(_orig_start, bufnr, lang)
            if ok then
                return result
            end
        end
    end

    if vim.treesitter.stop then
        vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
            group = vim.api.nvim_create_augroup("AbxTreesitterGuard", { clear = true }),
            callback = function(args)
                if M.should_skip(args.buf) then
                    pcall(vim.treesitter.stop, args.buf)
                end
            end,
        })
    end
end

return M
