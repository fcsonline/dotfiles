local status_configs, configs = pcall(require, "nvim-treesitter.configs")
if not status_configs then
  return
end

configs.setup {
  -- ensure_installed = "maintained",
  sync_install = false,
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  indent = { enable = true, disable = { "yaml" } },
}

local status_autotag, autotag = pcall(require, "nvim-ts-autotag")
if not status_autotag then
  return
end

autotag.setup()
