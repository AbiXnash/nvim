-- =============================================================================
-- Colorscheme Configuration
-- =============================================================================

return {
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
                hl(0, "Normal", { bg = "NONE" })
                hl(0, "NormalFloat", { bg = "NONE" })
                hl(0, "SignColumn", { bg = "NONE" })
                hl(0, "EndOfBuffer", { bg = "NONE" })
                hl(0, "StatusLine", { bg = "NONE" })
                hl(0, "StatusLineNC", { bg = "NONE" })
                hl(0, "WinBar", { bg = "NONE" })
                hl(0, "WinBarNC", { bg = "NONE" })
                hl(0, "TabLineFill", { bg = "NONE" })
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
}
