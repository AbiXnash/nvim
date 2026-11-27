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
	on_attach = function(client, bufnr)
		local augroup = vim.api.nvim_create_augroup("lspconfig.svelte", { clear = false })
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = augroup,
			pattern = { "*.js", "*.ts" },
			callback = function(ctx)
				client:notify("$/onDidChangeTsOrJsFile", { uri = vim.uri_from_bufnr(ctx.buf) })
			end,
		})

		vim.api.nvim_buf_create_user_command(bufnr, "LspMigrateToSvelte5", function()
			client:exec_cmd({
				title = "Migrate Component to Svelte 5 Syntax",
				command = "migrate_to_svelte_5",
				arguments = { vim.uri_from_bufnr(bufnr) },
			})
		end, { desc = "Migrate component to Svelte 5 syntax" })
	end,
}