local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Trigger PackerSync when there are no plugins installed
vim.cmd [[
  command! -nargs=1 Telescope PackerSync
  command! -nargs=1 NERDTreeToggle PackerSync
]]

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim"      -- Have packer manage itself
  use "nvim-lua/popup.nvim"         -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"       -- Useful lua functions used ny lots of plugins
  use 'preservim/nerdtree'          -- Best tree navigator
  use "ryanoasis/vim-devicons"      -- Icons for NERDTree
  use 'diepm/vim-rest-console'      -- REST console
  use 'thinca/vim-localrc'          -- Local vimrc config
  use 'ap/vim-css-color'            -- Colorize hexadecimal colors
  use 'wellle/targets.vim'          -- Modify faster (){}[] contents
  use 'vim-test/vim-test'           -- Run test file from vim
  use "nvim-lualine/lualine.nvim"   -- Setup line with nice style
  use 'AndrewRadev/switch.vim'      -- Switch / Toggle words
  use 'nvim-pack/nvim-spectre'      -- Find and replace
  use 'steelsojka/pears.nvim'       -- Auto pairs (){}[]
  use 'lewis6991/gitsigns.nvim'     -- Extra Git UI
  use 'rhysd/vim-grammarous'        -- A Grammarly like plugin
  use { 'ibhagwan/fzf-lua', requires = { 'kyazdani42/nvim-web-devicons' } } -- Fuzzy file finder
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- ast parser
  use 'windwp/nvim-ts-autotag'      -- auto close html,jsx,tsx,svelte tags

  -- My favourity colorscheme
  use({ 'catppuccin/nvim', as = 'catppuccin' })

  -- tpope zone
  use 'tpope/vim-commentary'        -- Toggle comments
  use 'tpope/vim-surround'          -- Surround, wrap or replace code with chars
  use 'tpope/vim-fugitive'          -- Git in vim
  use 'tpope/vim-dispatch'          -- Asynchronous build and test dispatcher
  use 'tpope/vim-endwise'           -- Complete blocks

  -- cmp plugins
  use 'hrsh7th/nvim-cmp'            -- The completion plugin
  use 'hrsh7th/cmp-buffer'          -- buffer completions
  use 'hrsh7th/cmp-path'            -- path completions
  use 'hrsh7th/cmp-cmdline'         -- cmdline completions
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'saadparwaiz1/cmp_luasnip'    -- snippet completions

  -- language completions
  use { 'saecki/crates.nvim', tag = 'v0.1.0', requires = { 'nvim-lua/plenary.nvim' }, config = function()
    if PACKER_BOOTSTRAP then
      return
    end

    require('crates').setup()
  end, } -- cargo completions
  use { 'David-Kunz/cmp-npm', requires = { 'nvim-lua/plenary.nvim' } } -- npm completions

  -- snippets
  use 'L3MON4D3/LuaSnip'            --snippet engine
  use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

  -- lsp
  use 'neovim/nvim-lspconfig'       -- enable LSP
  use 'williamboman/nvim-lsp-installer' -- simple to use language server installer
  use 'jose-elias-alvarez/null-ls.nvim' -- Extra LSP's

  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      if PACKER_BOOTSTRAP then
        return
      end

      require('trouble').setup {
        -- auto_open = true,
        -- auto_close = true
      }
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
