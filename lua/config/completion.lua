require("config.snippets")

vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "popup" }
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")
lspkind.init({})

local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "copilot" },
	},
	mapping = {
		-- Enter key confirms completion item
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		-- Previous item
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
		-- Next item
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = "select" }),
		-- Ctrl + space triggers completion menu
		["<C-Space>"] = cmp.mapping.complete(),
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			-- can also be a function to dynamically calculate max width such as
			-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			show_labelDetails = true, -- show labelDetails in menu. Disabled by default

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
		}),
	},
	completion = {
		completeopt = "menu,menuone,noselect,noinsert,popup",
	},
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
})
