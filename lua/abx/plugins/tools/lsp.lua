-- =============================================================================
-- LSP Configuration and Management
-- =============================================================================
-- Core LSP setup with Mason package manager and Fidget notifications
-- Updated Jan 2026: Enhanced server management and progress notifications
-- =============================================================================

return {
	-- Main LSP configuration for Neovim
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- LSP package manager - ensures servers are installed
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},

	config = function ()
		vim.lsp.config("*", {})
		vim.lsp.enable({"lua_ls"})
	end

}
