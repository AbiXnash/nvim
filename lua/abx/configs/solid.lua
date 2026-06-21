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

function M.is_solid_project(bufnr)
	bufnr = bufnr or 0
	local root = vim.fs.root(bufnr, { "package.json", "pnpm-workspace.yaml", ".git" })
	if not root then
		return false
	end

	local package_json = read_file(root .. "/package.json")
	if not package_json then
		return false
	end

	return package_json:find('"solid%-js"') ~= nil
		or package_json:find('"solid%-start"') ~= nil
		or package_json:find('"@solidjs/start"') ~= nil
end

function M.typescript_plugin_path()
	local root = vim.fs.root(0, { "package.json", "tsconfig.json", ".git" })
	if root then
		local local_plugin = root .. "/node_modules/typescript-plugin-solid"
		if vim.uv.fs_stat(local_plugin) then
			return local_plugin
		end
	end

	local global_root = vim.fn.systemlist({ "npm", "root", "-g" })[1]
	if global_root and global_root ~= "" and not global_root:match("^npm ERR") then
		local global_plugin = global_root .. "/typescript-plugin-solid"
		if vim.uv.fs_stat(global_plugin) then
			return global_plugin
		end
	end

	return nil
end

function M.setup_autocmds()
	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		group = vim.api.nvim_create_augroup("SolidJS", { clear = true }),
		pattern = { "*.tsx", "*.jsx", "*.ts", "*.js" },
		callback = function(args)
			if M.is_solid_project(args.buf) then
				vim.b[args.buf].solid_project = true
			end
		end,
	})
end

return M
