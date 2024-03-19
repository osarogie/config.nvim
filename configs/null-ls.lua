local null_ls = require "null-ls"

local b = null_ls.builtins
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt,                                                                                                                           -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "javascriptreact", "javascriptreact", "typescript", "typescriptreact" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  b.formatting.black,
  b.diagnostics.mypy.with({
    extra_args = function()
      local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
      return { "--python-executable", virtual .. "/bin/python3" }
    end,
  }),
  b.diagnostics.ruff,

  b.formatting.gofumpt,
  b.formatting.goimports_reviser,
  b.formatting.golines,
}

local opts = {
  debug = true,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}

return opts
