return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                background = {
                    dark = "mocha",
                },
                transparent_background = true,
                show_end_of_buffer = true,
                term_colors = false,
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.15,
                },
                no_italic = false,
                no_bold = false,
                no_underline = false,
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = { "bold" },
                    properties = {},
                    types = {},
                    operators = {},
                },
                lsp_styles = {
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                        ok = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                        ok = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                color_overrides = {
                    rosewater = "#f5e0dc",
                    flamingo = "#f2cdcd",
                    pink = "#f5c2e7",
                    mauve = "#cba6f7",
                    red = "#f38ba8",
                    maroon = "#eba0ac",
                    peach = "#fab387",
                    yellow = "#f9e2af",
                    green = "#a6e3a1",
                    teal = "#94e2d5",
                    sky = "#89dceb",
                    sapphire = "#74c7ec",
                    blue = "#89b4fa",
                    lavender = "#b4befe",
                    text = "#cdd6f4",
                    subtext1 = "#bac2de",
                    subtext0 = "#a6adc8",
                    overlay2 = "#9399b2",
                    overlay1 = "#7f849c",
                    overlay0 = "#6c7086",
                    surface2 = "#585b70",
                    surface1 = "#45475a",
                    surface0 = "#313244",
                    base = "#1e1e2e",
                    mantle = "#181825",
                    crust = "#11111b",
                },
                custom_highlights = {
                    LineNr = { fg = "#6c7086" },
                    Visual = { bg = "#45475a" },
                    Search = { bg = "#fab387", fg = "#1e1e2e" },
                    IncSearch = { bg = "#fab387", fg = "#1e1e2e" },
                    NormalFloat = { bg = "NONE" },
                    FloatBorder = { bg = "NONE", fg = "#6c7086" },
                    TelescopeBorder = { bg = "NONE", fg = "#6c7086" },
                    TelescopePromptBorder = { bg = "NONE", fg = "#6c7086" },
                    TelescopeResultsBorder = { bg = "NONE", fg = "#6c7086" },
                    TelescopePreviewBorder = { bg = "NONE", fg = "#6c7086" },
                    NvimTreeNormal = { bg = "NONE" },
                    NvimTreeVertSplit = { bg = "NONE", fg = "#313244" },
                    WinSeparator = { bg = "NONE", fg = "#313244" },
                    StatusLine = { bg = "NONE" },
                    StatusLineNC = { bg = "NONE", fg = "#6c7086" },
                    Pmenu = { bg = "NONE" },
                    PmenuSel = { bg = "#313244" },
                    PmenuSbar = { bg = "NONE" },
                    PmenuThumb = { bg = "#585b70" },
                    DiagnosticVirtualTextError = { fg = "#f38ba8", bg = "NONE" },
                    DiagnosticVirtualTextWarn = { fg = "#f9e2af", bg = "NONE" },
                    DiagnosticVirtualTextInfo = { fg = "#89dceb", bg = "NONE" },
                    DiagnosticVirtualTextHint = { fg = "#6c7086", bg = "NONE" },
                    DiagnosticError = { fg = "#f38ba8" },
                    DiagnosticWarn = { fg = "#f9e2af" },
                    DiagnosticInfo = { fg = "#89dceb" },
                    DiagnosticHint = { fg = "#6c7086" },
                    GitSignsAdd = { fg = "#a6e3a1" },
                    GitSignsChange = { fg = "#fab387" },
                    GitSignsDelete = { fg = "#f38ba8" },
                    Folded = { fg = "#6c7086", bg = "NONE" },
                    FoldColumn = { fg = "#6c7086", bg = "NONE" },
                    NormalDoc = { bg = "#1e1e2e" },
                },
                default_integrations = true,
                auto_integrations = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    mason = false,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                    blink_cmp = {
                        style = "none",
                    },
                },
            })

            -- vim.cmd.colorscheme "catppuccin"

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "catppuccin",
                callback = function()
                    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "NONE" })
                    vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "NONE" })
                end,
            })
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 99999,
        config = function()
            local function apply_gruvbox_overrides()
                local hl = vim.api.nvim_set_hl

                -- make main UI transparent
                hl(0, "Normal", { bg = "NONE" })
                hl(0, "NormalFloat", { bg = "NONE" })
                hl(0, "SignColumn", { bg = "NONE" })
                hl(0, "EndOfBuffer", { bg = "NONE" })

                -- STATUSLINE (this is the missing part)
                hl(0, "StatusLine", { bg = "NONE" })
                hl(0, "StatusLineNC", { bg = "NONE" })
                hl(0, "WinBar", { bg = "NONE" })
                hl(0, "WinBarNC", { bg = "NONE" })

                -- tabline
                hl(0, "TabLineFill", { bg = "NONE" })

                -- popup menu / cmp / blink
                hl(0, "Pmenu", { bg = "NONE" })
                hl(0, "FloatBorder", { bg = "NONE" })

                -- blink.nvim specific
                hl(0, "BlinkCmpMenu", { bg = "NONE" })
                hl(0, "BlinkCmpDoc", { bg = "NONE" })
                hl(0, "BlinkCmpSignatureHelp", { bg = "NONE" })
            end

            require("gruvbox").setup({
                terminal_colors = false, -- add neovim terminal colors
                undercurl = false,
                bold = false,
                italic = {
                    strings = false,
                    emphasis = true,
                    comments = true,
                    operators = false,
                    folds = false,
                },
                contrast = "hard", -- can be "hard", "soft" or empty string
                transparent_mode = true,
            })
            -- vim.cmd("colorscheme gruvbox")

            apply_gruvbox_overrides()

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "gruvbox",
                callback = apply_gruvbox_overrides,
            })
        end
    },

    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_material_transparent_background = 2
            vim.g.gruvbox_material_dim_inactive_windows = 0
            vim.g.gruvbox_material_float_style = "blend"
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_foreground = "material"

            local function apply_gruvbox_material_overrides()
                local hl = vim.api.nvim_set_hl

                -- make main UI transparent
                hl(0, "Normal", { bg = "NONE" })
                hl(0, "NormalFloat", { bg = "NONE" })
                hl(0, "SignColumn", { bg = "NONE" })
                hl(0, "EndOfBuffer", { bg = "NONE" })

                -- statusline / winbar / tabline
                hl(0, "StatusLine", { bg = "NONE" })
                hl(0, "StatusLineNC", { bg = "NONE" })
                hl(0, "WinBar", { bg = "NONE" })
                hl(0, "WinBarNC", { bg = "NONE" })
                hl(0, "TabLineFill", { bg = "NONE" })

                -- popup menu / cmp / blink
                hl(0, "Pmenu", { bg = "NONE" })
                hl(0, "FloatBorder", { bg = "NONE" })
                hl(0, "BlinkCmpMenu", { bg = "NONE" })
                hl(0, "BlinkCmpDoc", { bg = "NONE" })
                hl(0, "BlinkCmpSignatureHelp", { bg = "NONE" })
            end

            vim.cmd.colorscheme('gruvbox-material')
            apply_gruvbox_material_overrides()

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "gruvbox-material",
                callback = apply_gruvbox_material_overrides,
            })
        end
    },
    {
        "ramojus/mellifluous.nvim",
        -- version = "v0.*", -- uncomment for stable config (some features might be missed if/when v1 comes out)
        config = function()
            require("mellifluous").setup({
                transparent_background = {
                    enabled = true,
                    floating_windows = true,
                    telescope = true,
                    file_tree = true,
                    cursor_line = true,
                    status_line = true,
                },
            })
            -- vim.cmd("colorscheme mellifluous")
        end,
    }
}
