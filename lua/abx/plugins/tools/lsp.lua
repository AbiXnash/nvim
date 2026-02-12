-- =============================================================================
-- LSP Configuration and Management
-- =============================================================================
-- Core LSP setup with Mason package manager
-- =============================================================================
local enabled_servers = {
	"lua_ls",
	"gopls",
	"vtsls",
	"rust_analyzer"
}

return {
	{
		-- Main LSP configuration for Neovim
		"neovim/nvim-lspconfig",
		-- Load on startup so LSP can attach to new files created via netrw
		dependencies = {
			-- LSP package manager - ensures servers are installed
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},

		config = function()
			vim.lsp.enable(enabled_servers)
		end

	},
	{
		'mrcjkb/rustaceanvim',
		version = '^7', -- Recommended
		lazy = false, -- This plugin is already lazy
	}
}
