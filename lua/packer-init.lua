local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- gruvbox主题
    use 'morhetz/gruvbox'

    -- 自动补全插件
    require('lsp')
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    require('plugins/cmp').setup()
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'

    -- luasnip
    use 'rafamadriz/friendly-snippets'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'


    -- Lsp下载器
    use 'williamboman/mason-lspconfig.nvim'
    require('plugins/mason').setup()
    use {
        'williamboman/mason.nvim',
    }

    -- treesitter
    require("plugins.treesitter").setup()
    use { 'nvim-treesitter/nvim-treesitter' }

    -- nvim-tree
    use 'nvim-tree/nvim-web-devicons' -- optional, for file icons
    require("plugins/nvimtree").setup()
    use { 'nvim-tree/nvim-tree.lua' }

    -- ui
    require("plugins.bufferline").setup()
    use 'akinsho/bufferline.nvim'
    require("plugins.lualine").setup()
    use 'nvim-lualine/lualine.nvim'

    -- tmux
    -- use({
    --     "aserowy/tmux.nvim",
    --     config = function() require("plugins.tmux").setup() end
    -- })

    -- telescope
    use 'nvim-lua/plenary.nvim'
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }


    -- comment
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('plugins.comment').setup()
        end
    }

    -- 自动补全括号
    use {
        "windwp/nvim-autopairs",
        config = function() require("plugins.autopairs").setup() end
    }

    -- vim-surround
    use "tpope/vim-surround"


    -- markdown
    require("plugins.markdown").config()
    use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })




end)

if packer_bootstrap then
    require('packer').sync()
end
