-- Workarounds for neovim/neovim#36318: multiple LSP clients can produce
-- inlay hints with out-of-range columns when merged by the runtime.

local M = {}

local handler_filtered = false

--- Only one client should answer textDocument/inlayHint per buffer.
--- Secondary clients are disabled to avoid the runtime merge bug.
local preferred_client_by_filetype = {
	svelte = "svelte",
}

local function filter_invalid_hints(result, bufnr, client)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local filtered = {}

	for _, hint in ipairs(result) do
		local lnum = hint.position.line
		if lnum >= 0 and lnum < #lines then
			local line = lines[lnum + 1] or ""
			local col = vim.str_byteindex(line, client.offset_encoding, hint.position.character, true)
			if col ~= nil and col <= #line then
				filtered[#filtered + 1] = hint
			end
		end
	end

	return filtered
end

function M.setup_handler_filter()
	if handler_filtered then
		return
	end

	local handler = vim.lsp.handlers["textDocument/inlayHint"]
	if not handler then
		return
	end

	vim.lsp.handlers["textDocument/inlayHint"] = function(err, result, ctx, ...)
		if result and #result > 0 and ctx and ctx.bufnr and ctx.client_id then
			local client = vim.lsp.get_client_by_id(ctx.client_id)
			if client then
				result = filter_invalid_hints(result, ctx.bufnr, client)
			end
		end
		return handler(err, result, ctx, ...)
	end
	handler_filtered = true
end

function M.setup_lsp_attach()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("AbxInlayHints", { clear = true }),
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if not client then
				return
			end

			local preferred = preferred_client_by_filetype[vim.bo[bufnr].filetype]
			if preferred and client.name ~= preferred and client.server_capabilities.inlayHintProvider then
				client.server_capabilities.inlayHintProvider = false
			end

			if not vim.lsp.inlay_hint then
				return
			end

			local hint_clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/inlayHint" })
			if #hint_clients > 0 and not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }) then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end,
	})
end

function M.setup()
	M.setup_handler_filter()
	M.setup_lsp_attach()
end

return M