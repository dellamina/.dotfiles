local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
)

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions by lots of plugins
  use "cljoly/telescope-repo.nvim" -- Jump into the repositories of your filesystem
  use {"nvim-telescope/telescope-fzf-native.nvim", run = 'make' }
  use {
    "nvim-telescope/telescope.nvim", -- Fuzzy finder over lists
    config = function()
      require('telescope').load_extension("fzf")
      require("telescope").load_extension("repo")
    end,
    after = "plenary.nvim"
  }
  use {"andymass/vim-matchup"} -- better % navigate and highlight
  use {"kyazdani42/nvim-web-devicons"} -- lua `fork` of vim-web-devicons for neovim
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use {
    'notjedi/nvim-rooter.lua', -- A high performance plugin to change your working directory
    config = function() require'nvim-rooter'.setup() end
  }
  use "rhysd/clever-f.vim" -- Extended f, F, t and T key mappings for Vim

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

