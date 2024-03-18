---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR›", "window right" },
    ["<C-j›"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
    [">"] = { ">gv", "indent" },
    ["<leader>gg"] = { ":LazyGit<CR>", opts = { silent = true } },
    ["<leader>gG"] = { ":LazyGitCurrentFile<CR>", opts = { silent = true } },
    ["<leader>g?"] = { ":lua vim.diagnostic.open_float()<CR>" },
    ["<leader>tw"] = { ":set wrap<CR>", "set wrap" },
    -- ["gr"] = { "gd[{V%::s/<C-R>///gc<left><left><left>" },
    -- ["gR"] = { "gD:%s/<C-R>///gc<left><left><left>" }
    ["<C-z>"] = { ":undo <CR>", "Undo" },
  },
  i = {
    ["<C-z>"] = { "<C-o>u", "Undo" },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<leader>dus"] = {
      function()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    }
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dgl"] = {
      function()
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    }
  }
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags"
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags"
    }
  }
}

-- more keybinds!

return M
