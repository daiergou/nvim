local M = {}

function M.setup()
    require("bufferline").setup(
    {
        options = {
            separator_style = 'slant'
        }
    }
    )
end

return M
