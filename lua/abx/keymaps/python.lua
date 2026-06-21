local python = require("abx.configs.python")

local function nmap(lhs, rhs, opts)
    local default_opts = { noremap = true, silent = true }
    vim.keymap.set("n", lhs, rhs, vim.tbl_deep_extend("force", default_opts, opts or {}))
end

local function project_root()
    return vim.fs.root(vim.fn.expand("%:p:h"), python.root_markers) or vim.fn.getcwd()
end

local function file_dir()
    local filepath = vim.fn.expand("%:p")
    return filepath ~= "" and vim.fs.dirname(filepath) or nil
end

local function project_python()
    return python.find_python(project_root(), file_dir())
end

local function term_cmd(cmd)
    vim.cmd("belowright new | term " .. cmd .. "; stty echo")
end

nmap("<leader>pr", function()
    term_cmd(vim.fn.shellescape(project_python()) .. " " .. vim.fn.shellescape(vim.fn.expand("%:p")))
end, { desc = "Python: run file" })

nmap("<leader>pt", function()
    local file = vim.fn.expand("%:p")
    if file ~= "" then
        term_cmd(vim.fn.shellescape(project_python()) .. " -m pytest " .. vim.fn.shellescape(file))
    end
end, { desc = "Python: pytest file" })

nmap("<leader>pl", function()
    local root = project_root()
    term_cmd("cd " .. vim.fn.shellescape(root) .. " && " .. vim.fn.shellescape(project_python()) .. " -m pytest")
end, { desc = "Python: pytest project" })

nmap("<leader>pn", function()
    local test = vim.fn.expand("<cword>")
    if test ~= "" then
        local root = project_root()
        term_cmd("cd " .. vim.fn.shellescape(root) .. " && " .. vim.fn.shellescape(project_python()) .. " -m pytest -k " .. vim.fn.shellescape(test))
    end
end, { desc = "Python: pytest nearest" })

nmap("<leader>po", function()
    vim.cmd("LspPyrightOrganizeImports")
end, { desc = "Python: organize imports" })

nmap("<leader>pu", function()
    local root = project_root()
    local target = python.fastapi_target(nil, root)
    if not target then
        vim.notify("No FastAPI app found in this file or project", vim.log.levels.WARN)
        return
    end
    python.apply_venv(root, file_dir())
    term_cmd(
        "cd "
            .. vim.fn.shellescape(root)
            .. " && "
            .. vim.fn.shellescape(project_python())
            .. " -m uvicorn "
            .. target
            .. " --reload --host 127.0.0.1 --port 8000"
    )
end, { desc = "Python: run FastAPI (uvicorn --reload)" })
