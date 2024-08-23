require "config.snippets"

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

local lspkind = require "lspkind"
lspkind.init {}

local cmp = require "cmp"

cmp.setup {
  sources = {
    { name = "nvim_lsp" },
    { name = "cody" },
    { name = "path" },
    { name = "buffer" }
  },
  mapping = {
    -- Enter key confirms completion item
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    -- Previous item
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
    -- Next item
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" }),
    -- Ctrl + space triggers completion menu
    ["<C-Space>"] = cmp.mapping.complete(),
  },

  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  }
}
