---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR›", "window right" },
    ["<C-j›"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
    [">"] = { ">gv", "indent"},
    ["<leader>gg"] = { ":LazyGit<CR>", opts = { silent = true } },
    ["<leader>g?"] = { ":lua vim.diagnostic.open_float()<CR>" },
    -- " For local replace
-- nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

-- " For global replace
-- nnoremap gR gD:%s/<C-R>///gc<left><left><left>
    ["gr"] = { "gd[{V%::s/<C-R>///gc<left><left><left>" },
    ["gR"] = { "gD:%s/<C-R>///gc<left><left><left>" }
  },
}

-- more keybinds!

return M
