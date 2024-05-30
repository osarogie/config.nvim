return {
  'boltlessengineer/bufterm.nvim',
  config = function()
    require('bufterm').setup()
    local term = require('bufterm.terminal')
    local ui   = require('bufterm.ui')

    vim.keymap.set({ 'n', 't' }, '<C-t>', function()
      local recent_term = term.get_recent_term()
      ui.toggle_float(recent_term.bufnr)
    end, {
      desc = 'Toggle floating window with terminal buffers',
    })
  end,
}
