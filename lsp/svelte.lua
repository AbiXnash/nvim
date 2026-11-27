return {
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte" },
	settings = {
		typescript = {
			inlayHints = {
				parameterNames = {
					enabled = "literals",
					suppressWhenArgumentMatchesName = true,
				},
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
		},
	},
	-- No root_dir here: nvim-lspconfig's root_dir function resolves the project
	-- per buffer. (A `vim.fs.root(0, ...)` value was computed once at startup.)
	-- No on_attach: nvim-lspconfig's already sends $/onDidChangeTsOrJsFile on
	-- JS/TS saves and adds :LspMigrateToSvelte5.
}