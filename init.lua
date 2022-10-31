require("setting")
require("keymaps")
require("packer-init")
require("colorscheme")


-- 重载配置函数
function _G.reload_conf()
  for name,_ in pairs(package.loaded) do
    if name:match('^lsp') or name:match('^plugins') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify("配置重新加载完成!", vim.log.levels.INFO)
end
