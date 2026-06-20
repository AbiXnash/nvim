return {
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					{ "class\\s*=\\s*['\"]([^'\"]*)['\"]" },
					{ "classList\\s*=\\s*\\{([^}]*)\\}" },
					{ "className\\s*=\\s*['\"]([^'\"]*)['\"]" },
					{ "class:([a-zA-Z0-9\\-_:/\\[\\]\\.]+)" },
				},
			},
			includeLanguages = {
				typescript = "javascript",
				typescriptreact = "javascript",
				javascriptreact = "javascript",
			},
		},
	},
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"astro",
	},
}