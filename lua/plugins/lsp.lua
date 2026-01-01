return {
	"neovim/nvim-lspconfig",

	dependencies = {
		"williamboman/mason.nvim",
	},

	config = function()
		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Set default capabilities for all LSP servers
		vim.lsp.config("*", {
			capabilities = lsp_capabilities,
		})

		-- Configure individual servers using vim.lsp.config
		vim.lsp.config("htmx", {
			filetypes = { "html" },
		})

		vim.lsp.config("ts_ls", {
			root_markers = { "package.json" },
			single_file_support = false,
		})

		vim.lsp.config("eslint", {
			root_markers = { "queries", ".git" },
		})

		vim.lsp.config("denols", {
			root_markers = { "deno.json", "deno.jsonc" },
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
				},
			},
		})

		vim.lsp.config("marksman", {
			filetypes = { "markdown" },
		})

		vim.lsp.config("basedpyright", {
			settings = {
				pyright = {
					disableOrganizeImports = true,
				},
				basedpyright = {
					analysis = {
						typeCheckingMode = "basic",
					},
				},
			},
		})

		vim.lsp.config("ruff", {
			init_options = {
				settings = {
					loglevel = "debug",
				},
			},
		})

		vim.lsp.config("html", {
			filetypes = { "html", "templ" },
		})

		vim.lsp.config("tailwindcss", {
			filetypes = { "templ", "astro", "javascript", "typescript", "react" },
			settings = {
				tailwindCSS = {
					includeLanguages = {
						templ = "html",
					},
				},
			},
		})

		vim.lsp.config("yamlls", {
			filetypes = { "yaml", "yml" },
		})

		-- Enable all configured servers
		vim.lsp.enable({
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
			"html",
		})

		-- Setup mason
		require("mason").setup()
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
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
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
