return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      typescript = { "prettierd", stop_after_first = true },
      javascript = { "prettierd", stop_after_first = true },
      typescriptreact = { "prettierd", stop_after_first = true },
      javascriptreact = { "prettierd", stop_after_first = true },
      markdown = { "prettierd", stop_after_first = true },
      json = { "prettierd", stop_after_first = true },
      css = { "prettierd", stop_after_first = true },
      yaml = { "prettierd", stop_after_first = true },
      go = { "gofmt" },
      c = { "clang-format" },
      lua = { "stylua" },
      python = { "ruff_format" },
      kotlin = { "ktlint" },
      apex = { "prettierd" },
      sh = { "shfmt" },
      templ = { "templ" },
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
  },
}
