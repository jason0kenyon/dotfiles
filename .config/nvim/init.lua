--necessary for lsp front-end to function. Call ":Lsp<command" in normal mode to install, uninstall, check languages supported with autocomplete
require('plugins')

require("nvim-lsp-installer").setup {}
--Include component files, i.e., keybinds, pugins, etc.
require('binds')
require('cmp_cfg')
--Load plugin-provided snippets. Change ".lazy_load" to ".load" if you prefer complete loading upon startup. Lazy load staggers loading, preserving resources by loading snippets as neede
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
--Load custom snippets. Must be in vim format. Check out https://github.com/honza/vim-snippets for examples.
require("luasnip.loaders.from_snipmate").lazy_load({ path = { "$HOME/.config/nvim/snippets" } })
require'nvim-treesitter.configs'.setup {
    --syntax highlighting
     autotag ={
	enable=true
      },
    highlight = {
      enable = true,
      -- Setting this to true or a list of languages will run `:h syntax` and tree-sitter at the same time.
      additional_vim_regex_highlighting = false,
      additional_vim_regex_highlighting = {'org'},
    },
    ensure_installed = {'org'},
    --auto-indent
    indent = {
	enable = true,
    },
--[[convenient text selection. alter binds below as needed.
	incremental_selection = {
    	enable = true,
   	keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
    },
 },
 ]]
--basic vim configuration
vim.cmd([[
	let mapleader="\<Space>"
	set conceallevel=2
	set concealcursor=nc
	set clipboard=unnamedplus
	colorscheme dracula 
	set number
	set relativenumber
	"comment out the following two lines if you do not want folding
	set foldmethod=expr
        set foldexpr=nvim_treesitter#foldexpr()
]])
}
vim.opt.termguicolors = true
require("bufferline").setup{}
require('orgmode').setup_ts_grammar()
--file tree configuration
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1 
--include file tree and basic configuration. Check out https://github.com/kyazdani42/nvim-tree.lua for more advanced configuration and examples.
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})
--status bar. check out https://github.com/nvim-lualine/lualine.nvim for a list of themes and other more advanced configuration. If you don't have the proper fonts the bar 
--will not render correctly.
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

local builtin = require('telescope.builtin')
vim.keymap.set('n','<leader><leader>', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ff', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})

  require("telescope").setup {
    defaults = {
      mappings = {
        i = { ["<leader>q"] = "close"},
        n = { ["<leader>q"] = "close"},
        
      }
    }
  }

local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
local ts_conds = require('nvim-autopairs.ts-conds')
-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})
vim.keymap.set('n', '<leader>v', '<CMD>vsplit<CR>')
vim.keymap.set('n', '<leader>q', '<CMD>quit<CR>')
vim.keymap.set('n', '<leader>qq', '<CMD>q!<CR>')
vim.keymap.set('n', '<leader>wq', '<CMD>wq!<CR>')
