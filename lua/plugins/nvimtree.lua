local M = {}

function M.setup()
    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
            width = 30,
            side = "left",
            mappings = {
                list = {
                    { key = "u", action = "dir_up" },
                    { key = "l", action = "expand" },
                },
            },
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            },
        },
    })
end

return M
