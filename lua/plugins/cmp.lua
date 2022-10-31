local M = {}



local kind_icons = {
    -- if you change or add symbol here
    -- replace corresponding line in readme
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

function M.setup()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({ paths = { "./lua/snippets/" } })

    require("luasnip.config").set_config({
        snip_env = {
            s = require("luasnip.nodes.snippet").S,
            sn = require("luasnip.nodes.snippet").SN,
            t = require("luasnip.nodes.textNode").T,
            f = require("luasnip.nodes.functionNode").F,
            i = require("luasnip.nodes.insertNode").I,
            c = require("luasnip.nodes.choiceNode").C,
            d = require("luasnip.nodes.dynamicNode").D,
            r = require("luasnip.nodes.restoreNode").R,
            l = require("luasnip.extras").lambda,
            rep = require("luasnip.extras").rep,
            p = require("luasnip.extras").partial,
            m = require("luasnip.extras").match,
            n = require("luasnip.extras").nonempty,
            dl = require("luasnip.extras").dynamic_lambda,
            fmt = require("luasnip.extras.fmt").fmt,
            fmta = require("luasnip.extras.fmt").fmta,
            conds = require("luasnip.extras.expand_conditions"),
            types = require("luasnip.util.types"),
            events = require("luasnip.util.events"),
            parse = require("luasnip.util.parser").parse_snippet,
            ai = require("luasnip.nodes.absolute_indexer"),
            postfix = require "luasnip.extras.postfix".postfix,
        }
    })



    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' }, -- For luasnip users.
            { name = 'buffer' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'path' },
        },
        formatting = {
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                return vim_item
            end
        }

    })
end

return M
