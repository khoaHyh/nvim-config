return {
   {
     "nvim-treesitter/nvim-treesitter",
     build = ":TSUpdate",
     opts = {
       ensure_installed = {
         "apex",
         "c",
         "lua",
         "vim",
         "vimdoc",
         "query",
         "javascript",
         "html",
         "typescript",
         "tsx",
         "go",
         "markdown",
         "python",
       },
       sync_install = false,
       highlight = { enable = true },
       indent = { enable = true },
     },
   },
 }
