local M = {}

function M.setup()
    require("lualine").setup({
        options = {
            theme = 'gruvbox-material'
        }
    })
end

return M
