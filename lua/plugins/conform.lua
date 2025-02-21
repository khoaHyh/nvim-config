return {
  "stevearc/conform.nvim",
  config = function()
    local status_ok, conform = pcall(require, "conform")
    if not status_ok then
      return
    end

    conform.setup({

      formatters_by_ft = {
        -- Conform will run multiple formatters sequentially
        -- Use a sub-list to run only the first available formatter
        typescript = { "prettierd", "prettier" },
        javascript = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        go = { "gofmt" },
        c = { "clang-format" },
        lua = { "stylua" },
        python = { "ruff_format" },
        kotlin = { "ktlint" },
        apex = { "prettierd " }
      },
      ft_parsers = {
        javascript = "babel",
        javascriptreact = "babel",
        typescript = "typescript",
        typescriptreact = "typescript",
        css = "css",
        html = "html",
        json = "json",
        yaml = "yaml",
        markdown = "markdown",
      },
      format_after_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    })
  end,
}
