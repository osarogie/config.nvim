local overrides = require "custom.configs.overrides"

local function add_plugin(name, config)
  return {
    name,
    config = config,
  }
end

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }

  -- Essential plugins
  add_plugin "nvim-lua/popup.nvim",

  -- Autocompletion and LSP
  -- {
  --   "hrsh7th/nvim-cmp",
  --   -- dependencies = {
  --   --   {
  --   --     "zbirenbaum/copilot-cmp",
  --   --     config = function()
  --   --       require("copilot_cmp").setup()
  --   --     end,
  --   --   },
  --   -- },
  --   config = function()
  --     -- require('cmp').setup({

  --     -- })
  --     require('custom.configs.nvim-cmp')
  --   end,
  --   -- opts = {
  --   --   sources = {
  --   --     { name = "copilot",  group_index = 2 },
  --   --     { name = "nvim_lsp", group_index = 2 },
  --   --     { name = "luasnip",  group_index = 2 },
  --   --     { name = "buffer",   group_index = 2 },
  --   --     { name = "nvim_lua", group_index = 2 },
  --   --     { name = "path",     group_index = 2 },
  --   --   },
  --   -- },
  -- },
  add_plugin("L3MON4D3/LuaSnip", function()
    require("luasnip").config.setup {
      -- Add LuaSnip configuration here
    }
  end),

  -- Git integration
  add_plugin("lewis6991/gitsigns.nvim", function()
    require("gitsigns").setup {
      -- Add gitsigns configuration here
    }
  end),
  -- {
  --   "zbirenbaum/copilot.lua",
  --   -- Lazy load when event occurs. Events are triggered
  --   -- as mentioned in:
  --   -- https://vi.stackexchange.com/a/4495/20389
  --   event = "InsertEnter",
  --   -- You can also have it load at immediately at
  --   -- startup by commenting above and uncommenting below:
  --   -- lazy = false
  --   -- opts = overrides.copilot,
  --   config = function()
  --     require("copilot").setup({
  --       -- Add copilot configuration here
  --     })
  --   end,
  -- },
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- require("copilot").setup({
      --   -- Add copilot configuration here
      -- })
    end,
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function ()
  --     require("copilot_cmp").setup()
  --   end,
  --   event = { "InsertEnter", "LspAttach" },
  --   fix_pairs = true,
  -- },
  {
    "sbdchd/neoformat",
    lazy = false,
  },

  add_plugin "tpope/vim-fugitive",
  add_plugin "Eliot00/git-lens.vim",
  -- add_plugin("prettier/vim-prettier"),
  {
    "APZelos/blamer.nvim",
    lazy = false,
  },
  {
    "wellle/context.vim",
    lazy = false,
  },
}

return plugins
