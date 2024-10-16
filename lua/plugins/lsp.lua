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
			ensure_installed = { "clangd", "gopls", "ts_ls", "eslint", "lua_ls", "marksman", "pyright" },
			handlers = { default_setup },
		})

		mason.setup()

		lspconfig.clangd.setup({})
		lspconfig.gopls.setup({})
		lspconfig.ts_ls.setup({})
		lspconfig.eslint.setup({})
		lspconfig.lua_ls.setup({})
		lspconfig.marksman.setup({})
		lspconfig.pyright.setup({})

		local disable_semantic_tokens = {
			lua = true,
		}

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			-- group = vim.api.nvim_create_augroup("UserLspConfig", {}),
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
			end,
		})
	end,
}
