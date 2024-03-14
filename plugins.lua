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

  -- format & linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "python" },
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },

  {
    "neovim/nvim-lspconfig",
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
  -- {
  -- "wellle/context.vim",
  -- lazy = false,
  -- },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "yko/mojo.vim",
  },
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    -- optional for floating window border decoration
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension "lazygit"
    end,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
  },
  -- Formatting client: conform.nvim
  -- - configured to use black & isort in python
  -- - use the taplo-LSP for formatting in toml
  -- - Formatting is triggered via `<leader>f`, but also automatically on save
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- load the plugin before saving
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format { lsp_fallback = true }
        end,
        desc = "Format",
      },
    },
    opts = {
      formatters_by_ft = {
        -- first use isort and then black
        python = { "isort", "black" },
        -- "inject" is a special formatter from conform.nvim, which
        -- formats treesitter-injected code. Basically, this makes
        -- conform.nvim format python codeblocks inside a markdown file.
        markdown = { "inject" },
      },
      -- enable format-on-save
      format_on_save = {
        -- when no formatter is setup for a filetype, fallback to formatting
        -- via the LSP. This is relevant e.g. for taplo (toml LSP), where the
        -- LSP can handle the formatting for us
        lsp_fallback = true,
      },
    },
  },

  -- PYTHON REPL
  -- A basic REPL that opens up as a horizontal split
  -- - use `<leader>i` to toggle the REPL
  -- - use `<leader>I` to restart the REPL
  -- - `+` serves as the "send to REPL" operator. That means we can use `++`
  -- to send the current line to the REPL, and `+j` to send the current and the
  -- following line to the REPL, like we would do with other vim operators.
  {
    "Vigemus/iron.nvim",
    keys = {
      { "<leader>i", vim.cmd.IronRepl, desc = "󱠤 Toggle REPL" },
      { "<leader>I", vim.cmd.IronRestart, desc = "󱠤 Restart REPL" },

      -- these keymaps need no right-hand-side, since that is defined by the
      -- plugin config further below
      { "+", mode = { "n", "x" }, desc = "󱠤 Send-to-REPL Operator" },
      { "++", desc = "󱠤 Send Line to REPL" },
    },

    -- since irons's setup call is `require("iron.core").setup`, instead of
    -- `require("iron").setup` like other plugins would do, we need to tell
    -- lazy.nvim which module to via the `main` key
    main = "iron.core",

    opts = {
      keymaps = {
        send_line = "++",
        visual_send = "+",
        send_motion = "+",
      },
      config = {
        -- this defined how the repl is opened. Here we set the REPL window
        -- to open in a horizontal split to a bottom, with a height of 10
        -- cells.
        repl_open_cmd = "horizontal bot 10 split",

        -- This defines which binary to use for the REPL. If `ipython` is
        -- available, it will use `ipython`, otherwise it will use `python3`.
        -- since the python repl does not play well with indents, it's
        -- preferable to use `ipython` or `bypython` here.
        -- (see: https://github.com/Vigemus/iron.nvim/issues/348)
        repl_definition = {
          python = {
            command = function()
              local ipythonAvailable = vim.fn.executable "ipython" == 1
              local binary = ipythonAvailable and "ipython" or "python3"
              return { binary }
            end,
          },
        },
      },
    },
  },

  -- Configuration for the python debugger
  -- - configures debugpy for us
  -- - uses the debugpy installation from mason
  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      -- uses the debugypy installation by mason
      local debugpyPythonPath = require("mason-registry").get_package("debugpy"):get_install_path()
        .. "/venv/bin/python3"
      require("dap-python").setup(debugpyPythonPath, {})
    end,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- lightspeed
  {
    "ggandor/lightspeed.nvim",
    event = 'VeryLazy',
  },

  -- nvim-surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end
  },
}

return plugins
