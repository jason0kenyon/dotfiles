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
  
  --large collection of snippets
  use "rafamadriz/friendly-snippets"
  --snippet engine
  use 'L3MON4D3/LuaSnip'
  --allows cmp, the autocomplete engine, to interface with luasnip, the snippet engine.
  use 'saadparwaiz1/cmp_luasnip'
  --assists cmp with regular expression support
  use_rocks 'jsregexp'
  --colorschemes
  use 'folke/tokyonight.nvim'
  use 'Mofiqul/dracula.nvim'
  --custom autocomplete menu with icons 
  --file tree
use {
  requires = {'kyazdani42/nvim-web-devicons'}
}
  use {
  'kyazdani42/nvim-tree.lua',
  requires = {
    'kyazdani42/nvim-web-devicons', -- optional, for file icons
  },
  tag = 'nightly' -- optional, updated every week. (see issue #1193)
}
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

use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'kyazdani42/nvim-web-devicons'}
use 'nvim-lua/plenary.nvim'
use 'nvim-telescope/telescope.nvim'
   end
)


