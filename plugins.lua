local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  -- format & linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "python", "go" },
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
  { "nvim-lua/popup.nvim" },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").config.setup {
        -- Add LuaSnip configuration here
      }
    end,
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        -- Add gitsigns configuration here
      }
    end,
  },
  {
    "sbdchd/neoformat",
    lazy = false,
  },

  { "tpope/vim-fugitive" },
  { "Eliot00/git-lens.vim" },
  -- { "prettier/vim-prettier" },
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
    config = function()
      require("custom.configs.harpoon").setup()
    end,
  },
  {
    "yko/mojo.vim",
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings "dap_go"
    end,
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
        "<leader>fr",
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
    event = "VeryLazy",
  },

  -- nvim-surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings "gopher"
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>vs", "<cmd>VenvSelect<cr>" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    },
  },
  "tpope/vim-dotenv",
  "tpope/vim-rails",
  "tpope/vim-bundler",
  "tpope/vim-dispatch",
  "tpope/vim-dadbod",
  {
    'kristijanhusak/vim-dadbod-ui',
    config = function()
      require("custom.configs.dadbod").setup()
    end,
    dependencies = {
      {
        'tpope/vim-dadbod',
        lazy = true
      },
      {
        'kristijanhusak/vim-dadbod-completion',
        ft = { 'sql', 'mysql', 'plsql' },
        lazy = true
      },
      { "tpope/vim-dotenv" },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  "puremourning/vimspector",
  "prisma/vim-prisma",
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
    end,
    keys = {
      { "-", "<CMD>Oil<CR>" },
    },
  },
}

return plugins
