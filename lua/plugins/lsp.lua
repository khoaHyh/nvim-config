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
			ensure_installed = {
				"htmx",
				"clangd",
				"denols",
				"gopls",
				"templ",
				"ts_ls",
				"tailwindcss",
				"eslint",
				"kotlin_language_server",
				"lua_ls",
				"marksman",
				"basedpyright",
				"ruff",
				"yamlls",
			},
			handlers = { default_setup },
		})

		mason.setup()

		lspconfig.clangd.setup({})
		lspconfig.htmx.setup({
			filetypes = { "html" },
		})
		lspconfig.gopls.setup({})
		lspconfig.ts_ls.setup({
			-- need this to prevent denols and ts_ls both attached to the same buffer
			root_dir = lspconfig.util.root_pattern("package.json"),
			single_file_support = false,
		})
		lspconfig.eslint.setup({
			-- need this to prevent denols and ts_ls both attached to the same buffer
			root_dir = lspconfig.util.root_pattern("queries", ".git"),
		})
		lspconfig.denols.setup({
			root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
		})
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }, -- Declare `vim` as a global variable
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
					},
				},
			},
		})
		lspconfig.marksman.setup({ filetypes = { "markdown" } })
		lspconfig.basedpyright.setup({
			settings = {
				pyright = {
					-- Using Ruff's import organizers
					disableOrganizeImports = true,
				},
				basedpyright = {
					analysis = {
						-- ignore = { "*" },
						typeCheckingMode = "basic",
					},
				},
			},
		})
		lspconfig.ruff.setup({
			init_option = {
				settings = {
					loglevel = "debug",
				},
			},
		})
		lspconfig.yamlls.setup({})
		lspconfig.kotlin_language_server.setup({})
		lspconfig.templ.setup({})
		lspconfig.html.setup({
			filetypes = { "html", "templ" },
		})
		lspconfig.tailwindcss.setup({
			filetypes = { "templ", "astro", "javascript", "typescript", "react" },
			settings = {
				tailwindCSS = {
					includeLanguages = {
						templ = "html",
					},
				},
			},
		})

		local disable_semantic_tokens = {
			lua = true,
		}

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
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

				local filetype = vim.bo[bufnr].filetype
				if disable_semantic_tokens[filetype] then
					client.server_capabilities.semanticTokensProvider = nil
				end

				if client.name == "ruff" then
					-- Disable hover in favor of basedpyright
					client.server_capabilities.hoverProvider = false
				end
			end,
		})
	end,
}
