return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "williamboman/mason.nvim",
  },

  config = function()
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    local default_setup = function(server)
      require("lspconfig")[server].setup({
        capabilities = lsp_capabilities,
      })
    end

    local lspconfig = require("lspconfig")
    local mason = require("mason")
    require("mason-lspconfig").setup({
      ensure_installed = { "apex_ls", "clangd", "denols", "gopls", "ts_ls", "eslint", "kotlin_language_server", "lua_ls", "marksman", "pyright", "ruff", "yamlls" },
      handlers = { default_setup },
    })

    mason.setup()

    lspconfig.clangd.setup({})
    lspconfig.gopls.setup({})
    lspconfig.ts_ls.setup({
      -- need this to prevent denols and ts_ls both attached to the same buffer
      root_dir = lspconfig.util.root_pattern("package.json"),
      single_file_support = false
    })
    lspconfig.eslint.setup({
      -- need this to prevent denols and ts_ls both attached to the same buffer
      root_dir = lspconfig.util.root_pattern('queries', '.git')
    })
    lspconfig.denols.setup({
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    })
    lspconfig.lua_ls.setup({})
    lspconfig.marksman.setup({})
    lspconfig.apex_ls.setup({
      apex_enable_semantic_errors = false,
      apex_enable_completion_statistics = false,
      filetypes = { 'apex' },
      root_dir = lspconfig.util.root_pattern('sfdx-project.json'),
    })
    -- NTS: you need node running in the current context in order for pyright to work. Maybe something to fix with Mason?
    lspconfig.pyright.setup({
      settings = {
        pyright = {
          -- Using Ruff's import organizers
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            inlayHints = {
              variableTypes = true,
              functionReturnTypes = true
            },
            ignore = { '*' },
            typeCheckingMode = "off"
          },
        },
      },
    })
    lspconfig.ruff.setup({
      init_option = {
        settings = {
          loglevel = 'error'
        }
      }
    })
    lspconfig.yamlls.setup({})
    lspconfig.kotlin_language_server.setup({})

    local disable_semantic_tokens = {
      lua = true,
    }

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
      callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

        local builtin = require("telescope.builtin")

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
        vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

        vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
        vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })

        local filetype = vim.bo[bufnr].filetype
        if disable_semantic_tokens[filetype] then
          client.server_capabilities.semanticTokensProvider = nil
        end

        if client.name == 'ruff' then
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end
      end,
    })
  end,
}
