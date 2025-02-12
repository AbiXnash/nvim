return {
	-- Adds support for JSX/TSX syntax highlighting
	{ "pangloss/vim-javascript" },
	{ "maxmellon/vim-jsx-pretty" },

	-- Treesitter support for better syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "javascript", "typescript", "tsx" })
		end,
	},

	-- LSP setup for React (TS/JS)
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.servers = opts.servers or {}
			opts.servers.tsserver = {
				settings = {
					javascript = { inlayHints = { includeInlayParameterNameHints = "all" } },
					typescript = { inlayHints = { includeInlayParameterNameHints = "all" } },
				},
			}
		end,
	},

	-- Auto-completions and snippets
	{ "windwp/nvim-ts-autotag", config = true }, -- Auto-close JSX/TSX tags
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "L3MON4D3/LuaSnip" },
}
