local M = {}
function M.setup()
    require 'nvim-treesitter.configs'.setup {
        -- 确保安装的语言
        ensure_installed = { "lua", "rust" },

        -- 同步安装语言解析器(仅适用于在`ensure_installed`的语言)
        sync_install = false,

        -- 进入缓冲区的时候自动安装缺少的语言解析器
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- 要忽略安装的语言
        ignore_install = {},

        highlight = {

            enable = true,
            -- 这里填写的是解析器的名字
            disable = {},

            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true, disable = { "python", "css" } },
        autopairs = {
            enable = true,
        },

    }
end

return M
