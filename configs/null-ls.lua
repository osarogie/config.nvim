local null_ls = require "null-ls"

local fmt = null_ls.builtins.formatting
local dgn = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {
  fmt.trim_whitespace.with {
    filetypes = { "text", "sh", "zsh", "toml", "make", "conf", "tmux" },
  },
  -- webdev stuff
  fmt.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  fmt.prettierd,
  fmt.prettier.with {
    filetypes = { "html", "markdown", "css", "javascriptreact", "javascriptreact", "typescript", "typescriptreact" },
  }, -- so prettier works only on these filetypes

  -- Lua
  fmt.stylua,

  -- cpp
  fmt.clang_format,

  fmt.black,
  dgn.mypy.with {
    extra_args = function()
      local virtual = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX" or "/usr"
      return { "--python-executable", virtual .. "/bin/python3" }
    end,
  },
  dgn.ruff,

  fmt.gofumpt,
  fmt.goimports_reviser,
  fmt.golines,
  fmt.terraform_fmt,
  fmt.eslint_d,
  dgn.eslint_d,
  dgn.shellcheck,
  dgn.luacheck.with {
    extra_args = { "--globals", "vim", "--std", "luajit" },
  },
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
