-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "sonokai"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-Right>"] = ":vs<cr>"
lvim.keys.normal_mode["<S-Down>"] = ":sp<cr>"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["r"] = {
  name = "+Run/Execute",
  l = { ":!lua %<cr>", "Lua Code" },
  j = { ":!node %<cr>", "JavaScript Code" },
  p = { ":!python3 %<cr>", "Python Code" },
  n = { ":!npm i<cr>", "NPM Clean Install" },
  c = { ":FloatermNew --height=0.6 --width=0.5 --wintype=float --title=HackingTerminal<cr>", "Open Terminal" }
}

lvim.builtin.which_key.mappings["0"] = {
  name = "+Configurations",
  e = {
    name = "+Environment Variables",
    l = {
      name = "+Logger",
      u = { ":let $LOGGER_ENABLED='true'<cr>", "Enable Logging" },
      d = { ":let $LOGGER_ENABLED='false'<cr>", "Disable Logging" },
    }
  },
  s = {
    name = "+Spelling",
    u = { ":let g:enable_spelunker_vim = 1<cr>", "Enable Spelling" },
    d = { ":let g:enable_spelunker_vim = 0<cr>", "Disable Spelling" },
  }
}

lvim.builtin.which_key.mappings["t"] = {
  name = "+Tests",
  n = { ":TestNearest<cr>", "Test Nearest" },
  f = { ":TestFile<cr>", "Test File" },
  l = { ":TestLast<cr>", "Last Test" }
}

lvim.builtin.which_key.mappings["g"] = {
  name = "+Git",
  o = { ":G<cr>", "Open" },
  p = { ":G push<cr>", "Push" },
}

lvim.builtin.which_key.mappings["z"] = { ":ZenMode<cr>", "Zen Mode" }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent = { enable = true, disable = { "javascript", "typescript", "vue", "python" } }

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "black",
    filetypes = { "python" }
  },
  {
    command = "isort",
    extra_args = { "--profile", "black" },
    filetypes = { "python" }
  },
  {
    command = "prettier",
    filetypes = { "typescript", "typescriptreact", "javascript", "vue", "htmldjango", "html" },
  },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { command = "flake8", filetypes = { "python" } },
  -- {
  --   -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "shellcheck",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--severity", "warning" },
  -- },
  -- {
  --   command = "codespell",
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "javascript", "python" },
  -- },
}

-- Additional Plugins
lvim.plugins = {
  { "sainnhe/sonokai" },
  { "easymotion/vim-easymotion" },
  { "vim-test/vim-test" },
  { "voldikss/vim-floaterm" },
  { "preservim/vimux" },
  { "kamykn/spelunker.vim" },
  { "ruanyl/coverage.vim" },
  { "vimwiki/vimwiki" },
  { "mattn/emmet-vim" },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
  {
    "mattn/vim-gist",
    event = "BufRead",
    requires = "mattn/webapi-vim",
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {}
    end
  }
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  { "BufWinEnter", "*.ts", "setlocal ts=4 sw=4" },
}

-- Confioguration for Sonokai Theme
vim.cmd([[
    let g:sonokai_style = 'atlantis'
    let g:sonokai_enable_italic = 1
    let g:sonokai_disable_italic_comment = 0

    nmap s <Plug>(easymotion-s2)
    nmap t <Plug>(easymotion-t2)

    let test#strategy = "floaterm"
    let test#javascript#jest#options = '--silent --verbose'

    let g:enable_spelunker_vim = 0
    let g:user_emmet_leader_key='<C-Z>'
]])

vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
