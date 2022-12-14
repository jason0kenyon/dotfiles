return require('packer').startup(function(use)
  -- Packer can manage itself. Just clone it and you can forget about it. Call ":Packer<command>" to manage your plugins.
  use 'wbthomason/packer.nvim'
  -- lspconfig is the base package for the langauge servers(these are used by syntax highlighting and autocomplete).lsp-installer is simple front-end for installing new language servers
  -- Just call ":Lsp<command>" to manage your language servers
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  --auto-completion engine base
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'onsails/lspkind.nvim'
 use 'ThePrimeagen/vim-be-good'
use {"akinsho/toggleterm.nvim", tag = '*', config = function()
  require("toggleterm").setup()
end}
use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
   }
  --large collection of snippets
  use "rafamadriz/friendly-snippets"
use {"akinsho/toggleterm.nvim", tag = '*', config = function()
  require("toggleterm").setup()
end}
  --snippet engine
  use 'windwp/nvim-ts-autotag'
  use 'L3MON4D3/LuaSnip'
  --allows cmp, the autocomplete engine, to interface with luasnip, the snippet engine.
  use 'saadparwaiz1/cmp_luasnip'
  --assists cmp with regular expression support
  use_rocks 'jsregexp'
  --colorschemes
  use 'nvim-tree/nvim-web-devicons'
  use 'folke/tokyonight.nvim'
  use 'Mofiqul/dracula.nvim'
  use 'https://github.com/RRethy/vim-illuminate.git'
--custom autocomplete menu with icons 
  --file tree
  use 'kyazdani42/nvim-tree.lua'
  --status bar
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}
 --syntax highlighting and auto-indentation. Call ":TS<command>" to manage your language parsers. These are used for highliting and indenting correctly.
  use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
	}

use {'nvim-treesitter/nvim-treesitter'}
use {'nvim-orgmode/orgmode', config = function()
        require('orgmode').setup{}
end
}
use 'dhruvasagar/vim-table-mode'
use {'akinsho/org-bullets.nvim', config = function()
  require('org-bullets').setup()
end}
use {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}
use 'akinsho/bufferline.nvim'
use 'nvim-lua/plenary.nvim'
use 'nvim-telescope/telescope.nvim'
   end
)


