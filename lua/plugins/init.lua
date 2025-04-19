return {
  "nvim-lua/plenary.nvim",
  -- colorschemes START --
  "sainnhe/gruvbox-material",
  "sainnhe/everforest",
  {
    "rose-pine/neovim",
    name = "rose-pine",
    variant = "auto",
    dark_variant = "moon",
    styles = {
      bold = true,
      italic = true,
      transparency = false
    }
  },
  -- colorschemes END --
  "nvim-tree/nvim-web-devicons",
  "nvim-telescope/telescope-media-files.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require "config.completion"
    end
  },
  "hrsh7th/cmp-nvim-lsp",
  "JoosepAlviste/nvim-ts-context-commentstring", -- Comments
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  "kevinhwang91/nvim-bqf"
}
