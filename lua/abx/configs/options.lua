-- Prepend Homebrew bin to PATH (supports both Apple Silicon and Intel Macs)
for _, prefix in ipairs({ "/opt/homebrew", "/usr/local" }) do
    local bin = prefix .. "/bin"
    if vim.fn.isdirectory(bin) == 1 then
        vim.env.PATH = bin .. ":" .. vim.env.PATH
        break
    end
end

vim.g.have_nerd_font = true

vim.opt.guicursor = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.inccommand = "split"
vim.opt.scrolloff = 20
vim.opt.wrap = false
vim.opt.textwidth = 0
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.mouse = ""
vim.opt.clipboard = ""
vim.opt.hidden = true
vim.opt.history = 1000
vim.opt.termguicolors = true
vim.opt.list = false

-- Disable document highlight (we don't use it)
vim.lsp.handlers["textDocument/documentHighlight"] = function() end

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.api.nvim_create_autocmd({ "BufRead" }, {
    pattern = { "*.tmpl", "*.gotmpl" },
    callback = function(args)
        vim.bo[args.buf].filetype = "gotmpl"
    end,
})
