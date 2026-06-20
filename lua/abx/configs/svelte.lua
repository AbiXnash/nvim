local M = {}

local function read_file(path)
	local fd = io.open(path, "r")
	if not fd then
		return nil
	end
	local content = fd:read("*a")
	fd:close()
	return content
end

function M.is_svelte_project(bufnr)
	bufnr = bufnr or 0
	local root = vim.fs.root(bufnr, {
		"package.json",
		"svelte.config.js",
		"svelte.config.ts",
		"svelte.config.mjs",
		".git",
	})
	if not root then
		return false
	end

	for _, config in ipairs({
		"svelte.config.js",
		"svelte.config.ts",
		"svelte.config.mjs",
		"svelte.config.cjs",
	}) do
		if vim.uv.fs_stat(root .. "/" .. config) then
			return true
		end
	end

	local package_json = read_file(root .. "/package.json")
	if not package_json then
		return false
	end

	return package_json:find('"@sveltejs/kit"') ~= nil
		or package_json:find('"@sveltejs/vite%-plugin%-svelte"') ~= nil
		or package_json:find('"svelte"') ~= nil
end

function M.typescript_plugin_path()
	local candidates = {}

	local root = vim.fs.root(0, { "package.json", "tsconfig.json", ".git" })
	if root then
		table.insert(candidates, root .. "/node_modules/typescript-svelte-plugin")
	end

	table.insert(candidates, vim.fn.stdpath("data")
		.. "/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin")

	for _, path in ipairs(candidates) do
		if vim.uv.fs_stat(path) then
			return path
		end
	end

	return nil
end

function M.setup_autocmds()
	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		group = vim.api.nvim_create_augroup("SvelteKit", { clear = true }),
		pattern = { "*.svelte", "*.ts", "*.js" },
		callback = function(args)
			if M.is_svelte_project(args.buf) then
				vim.b[args.buf].svelte_project = true
			end
		end,
	})
end

return M