-- 恢复文件上次光标所在的位置
vim.api.nvim_command([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- 打开TODO文件
vim.api.nvim_create_user_command("TODO", function()
    local dir = vim.fn.getcwd() .. "/todo"
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end
    local file = dir .. "/" .. os.date("%Y-%m-%d") .. "-TODO.md"
    if vim.fn.filereadable(file) then
        file = "e " .. file
    else
        vim.api.nvim_command("ene")
        file = "w " .. file
    end
    vim.api.nvim_command(file)
end, { desc = "创建当天日期的todo.md" })


-- 映射leader键
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local mappings = {
    -- 无效的按键
    { "n", "s", "<Nop>", opts },
    { "n", "<left>", "<Nop>", opts },
    { "n", "<right>", "<Nop>", opts },
    { "n", "<up>", "<Nop>", opts },
    { "n", "<down>", "<Nop>", opts },
    { "n", "Q", "<Nop>", opts },
    { "n", "<F1>", "<Nop>", opts },

    -- unundo
    { "n", "U", "<C-r>", opts },


    -- 节省操作
    { "i", "jk", "<Esc>", opts },
    { "n", "<leader>q", "<cmd>q<CR>", opts },
    { "n", "<leader>w", "<cmd>w<CR>", opts },
    { "n", "<leader>h", "<cmd>nohlsearch<CR>", opts },

    -- 缩进
    { 'v', '<', '<gv', opts },
    { 'v', '>', '>gv', opts },
    { 'v', '<s-tab>', '<gv', opts },
    { 'v', '<tab>', '>gv', opts },

    -- 窗口操作
    { "n", "<C-h>", "<C-w>h", opts },
    { "n", "<C-j>", "<C-w>j", opts },
    { "n", "<C-k>", "<C-w>k", opts },
    { "n", "<C-l>", "<C-w>l", opts },
    { "n", "<leader>c", "<cmd>Bdelete!<CR>", opts },
    { "n", "<leader>--", "<cmd>sp<CR>", opts },
    { "n", "<leader>\\", "<cmd>vsp<CR>", opts },

    -- 重载配置
    { "n", "<leader>sv", "<cmd>lua reload_conf()<CR>", opts },

    -- buffer操作
    { "n", "H", "<cmd>bp<CR>", opts },
    { "n", "L", "<cmd>bn<CR>", opts },
    { "n", "<leader>c", "<cmd>bd<CR>", opts },
    { "n", "<leader>C", "<cmd>%bdelete<CR>", opts },
    -- 打开目录
    { "n", "<leader>e", "<cmd>:NvimTreeToggle<CR>", opts },


    -- 文件的模糊查询
    { "n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts },
    { "n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts },
    { "n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts },
    { "n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts },

    -- 粘贴 
    { "v", "p", '"_dP', opts }


}

for _, m in pairs(mappings) do
    map(m[1], m[2], m[3], m[4])
end
