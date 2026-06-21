local M = {}

local venv_names = { ".venv", "venv", "env" }

local function venv_python_at(dir, name)
    local venv = dir .. "/" .. name
    local python = venv .. "/bin/python"
    if vim.uv.fs_stat(python) then
        return python, venv
    end
end

function M.find_python(root, start_dir)
    start_dir = start_dir or root
    if start_dir then
        local dir = start_dir
        while dir and dir ~= "/" do
            for _, name in ipairs(venv_names) do
                local python, venv = venv_python_at(dir, name)
                if python then
                    return python, venv
                end
            end
            dir = vim.fs.dirname(dir)
        end
    end

    if vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV ~= "" then
        local python = vim.env.VIRTUAL_ENV .. "/bin/python"
        if vim.uv.fs_stat(python) then
            return python, vim.env.VIRTUAL_ENV
        end
    end

    return vim.fn.exepath("python3"), nil
end

function M.apply_venv(root, start_dir)
    local python, venv = M.find_python(root, start_dir)
    if venv then
        vim.env.VIRTUAL_ENV = venv
        local bin = venv .. "/bin"
        if not vim.env.PATH:find(bin, 1, true) then
            vim.env.PATH = bin .. ":" .. vim.env.PATH
        end
    end
    return python
end

function M.apply_to_basedpyright(client, bufnr)
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    local start_dir = filepath ~= "" and vim.fs.dirname(filepath) or nil
    local root = vim.fs.root(bufnr, M.root_markers)
    local python, venv = M.find_python(root, start_dir)

    if python == "" then
        return
    end

    if venv then
        vim.env.VIRTUAL_ENV = venv
        local bin = venv .. "/bin"
        if not vim.env.PATH:find(bin, 1, true) then
            vim.env.PATH = bin .. ":" .. vim.env.PATH
        end
    end

    local python_settings = { pythonPath = python }
    if venv then
        python_settings.venvPath = vim.fs.dirname(venv)
        python_settings.venv = vim.fs.basename(venv)
    end

    local settings = vim.tbl_deep_extend("force", client.settings or {}, {
        python = python_settings,
    })
    client.settings = settings
    client:notify("workspace/didChangeConfiguration", { settings = settings })
end

M.root_markers = {
    "pyrightconfig.json",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "manage.py",
    ".git",
}

function M.module_from_file(root, filepath)
    if not root or not filepath or not filepath:find(root, 1, true) then
        return nil
    end
    return filepath:sub(#root + 2):gsub("%.py$", ""):gsub("/", ".")
end

function M.find_fastapi_app(root)
    local candidates = {
        "main.py",
        "app.py",
        "src/main.py",
        "src/app.py",
        "api/main.py",
        "app/main.py",
    }

    for _, rel in ipairs(candidates) do
        local path = root .. "/" .. rel
        if vim.uv.fs_stat(path) then
            local ok, lines = pcall(vim.fn.readfile, path)
            if ok then
                for _, line in ipairs(lines) do
                    local app_name = line:match("(%w+)%s*=%s*FastAPI%(")
                    if app_name then
                        return M.module_from_file(root, path) .. ":" .. app_name
                    end
                end
            end
        end
    end
end

function M.fastapi_target(bufnr, root)
    root = root or vim.fs.root(bufnr or 0, M.root_markers)
    if not root then
        return nil
    end

    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    for _, line in ipairs(lines) do
        local app_name = line:match("(%w+)%s*=%s*FastAPI%(")
        if app_name then
            local filepath = vim.api.nvim_buf_get_name(bufnr)
            local module = M.module_from_file(root, filepath)
            if module then
                return module .. ":" .. app_name
            end
        end
    end

    return M.find_fastapi_app(root)
end

return M
