local M = {}

local on_attach = function(client, bufnr)

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    local keymap = vim.keymap.set
    keymap('n', 'gD', vim.lsp.buf.declaration, bufopts)
    keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
    keymap('n', 'gr', vim.lsp.buf.references, bufopts)
    keymap('n', 'K', vim.lsp.buf.hover, bufopts)
    keymap('n', 'gi', vim.lsp.buf.implementation, bufopts)
    keymap('n', '<C-p>', vim.lsp.buf.signature_help, bufopts)
    keymap('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    keymap('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    keymap('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
    keymap('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local servers = {
    "sumneko_lua",
    "rust_analyzer",
    "marksman",
    "pylsp",
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end
local server_opts = {}

function M.setup()
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- lsp诊断的符号
    local signs = { Error = "", Warn = "", Hint = "", Info = "" }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
   end

    server_opts = { on_attach = on_attach, }

    for _, server in pairs(servers) do
        local require_ok, conf_opts = pcall(require, "lsp.providers." .. server)
        if require_ok then
            server_opts = vim.tbl_deep_extend("force", conf_opts, server_opts)
        end
        lspconfig[server].setup(server_opts)
    end
end

return M
