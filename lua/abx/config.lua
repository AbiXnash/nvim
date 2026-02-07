-- =============================================================================
-- ABX Configuration - Centralized Settings
-- =============================================================================
-- All hardcoded values should be defined here for easy modification
-- =============================================================================

local Config = {}

-- =============================================================================
-- LSP Configuration
-- =============================================================================
-- Config.lsp = {
-- 	-- Format timeout (ms)
-- 	format_timeout = 4000,
--
-- 	-- Diagnostic signs
-- 	diagnostic_signs = {
-- 		error = "",
-- 		warn = "",
-- 		info = "",
-- 		hint = "󰌵",
-- 	},
--
-- 	-- Diagnostic settings
-- 	diagnostics = {
-- 		signs = true,
-- 		severity_sort = true,
-- 	},
--
-- 	-- Server list (enabled via vim.lsp.enable)
-- 	-- Recent updates: Migrated from typescript-tools to vtsls for better TS/JS support
-- 	-- Added comprehensive web development support (html, htmx, json_ls)
-- 	servers = {
-- 		"lua_ls",
-- 		"rust_analyzer",
-- 		"svelte",
-- 		"astro",
-- 		"vtsls", -- Updated: Replaced typescript-tools for improved TS/JS LSP support
-- 		"gopls",
-- 		"basedpyright",
-- 		"jdtls",
-- 		"marksman",
-- 		"html",
-- 		"yamlls",
-- 		"lemminx", -- XML language server
-- 		"sqlls",
-- 		"kotlin_language_server",
-- 	},
-- }
--
-- -- =============================================================================
-- -- Telescope Configuration
-- -- =============================================================================
-- Config.telescope = {
-- 	-- File patterns to ignore
-- 	ignore_patterns = { "node_modules", ".git/", "target", "build" },
--
-- 	-- Layout strategy
-- 	layout_strategy = "bottom_pane",
-- }
--
-- -- =============================================================================
-- -- Treesitter Configuration
-- -- =============================================================================
-- Config.treesitter = {
-- 	-- Maximum file size for syntax highlighting (bytes)
-- 	max_file_size = 100 * 1024,
--
-- 	-- Languages to ensure are installed
-- 	-- Recent updates: Added htmx support for modern web development
-- 	-- Enhanced SQL support for database development
-- 	ensure_installed = {
-- 		"lua",
-- 		"vimdoc",
-- 		"java",
-- 		"jsdoc",
-- 		"python",
-- 		"rust",
-- 		"javascript",
-- 		"typescript",
-- 		"json",
-- 		"yaml",
-- 		"toml",
-- 		"css",
-- 		"html",
-- 		"scss",
-- 		"go",
-- 		"cpp",
-- 		"c",
-- 		"bash",
-- 		"fish",
-- 		"markdown",
-- 		"vue",
-- 		"svelte",
-- 		"astro",
-- 		"sql",
-- 		"regex",
-- 		"templ",
-- 	},
-- }
--
-- -- =============================================================================
-- -- Formatter Configuration
-- -- =============================================================================
-- Config.formatters = {
-- 	-- Prettier args
-- 	prettier_args = { "--tab-width", "4", "--use-tabs", "false" },
--
-- 	-- Google Java Format args
-- 	google_java_format_args = { "--aosp", "--line-length=100" },
--
-- 	-- Format on save settings
-- 	format_on_save = {
-- 		timeout_ms = 500,
-- 		lsp_fallback = false,
-- 	},
-- }
--
--
-- =============================================================================
-- Keymapping Groups (for reference)
-- =============================================================================
Config.keymaps = {
	-- Window navigation
	window_nav = {
		left = "<C-h>",
		right = "<C-l>",
		down = "<C-j>",
		up = "<C-k>",
	},

	-- Scroll centering
	scroll_center = {
		page_down = "<C-d>",
		page_up = "<C-u>",
	},

	-- LSP keymaps prefix
	lsp_prefix = "<leader>",
}


return Config
