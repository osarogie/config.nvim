local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

vim.opt.colorcolumn = "100"
vim.g.copilot_assume_mapped = true
vim.g.copilot_filetypes = {
  ["*"] = true,
  ["javascript"] = true,
  ["typescript"] = true,
  ["lua"] = false,
  ["rust"] = true,
  ["c"] = true,
  ["c#"] = true,
  ["c++"] = true,
  ["go"] = true,
  ["python"] = true,
}
vim.wo.relativenumber = true
-- vim.g.copilot_no_tab_map = true
-- vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  command = "Neoformat prettier",
})
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
vim.cmd [[autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx Neoformat prettier]]
vim.g.blamer_enabled = 1
vim.g.blamer_delay = 300
vim.g.blamer_relative_time = 1
-- vim.g.context_enables = 1
vim.g.neoformat_try_node_exe = 1
-- vim.g.context_max_height = 5
vim.g.zig_fmt_autosave = 0
