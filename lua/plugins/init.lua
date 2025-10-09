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
			transparency = false,
		},
	},
	-- colorschemes END --
	"nvim-tree/nvim-web-devicons",
	"nvim-telescope/telescope-media-files.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
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
			require("config.completion")
		end,
	},
	"hrsh7th/cmp-nvim-lsp",
	"JoosepAlviste/nvim-ts-context-commentstring", -- Comments
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},
	"kevinhwang91/nvim-bqf",
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		},
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			file_types = { "markdown", "codecompanion" },
		},
		ft = { "markdown", "codecompanion" },
	},
	"github/copilot.vim",
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"github/copilot.vim",
		},
		opts = {
			strategies = {
				chat = {
					adapter = "copilot",
					model = "claude-3.7-sonnet",
				},
				inline = {
					adapter = "copilot",
					model = "claude-3.7-sonnet",
				},
				cmd = {
					adapter = "copilot",
					model = "claude-3.7-sonnet",
				},
			},
			adapters = {
				http = {
					copilot = function()
						return require("codecompanion.adapters").extend("copilot", {
							schema = {
								model = {
									default = "claude-3.7-sonnet",
								},
							},
						})
					end,
				},
			},
			display = {
				chat = {
					post_open_hook = function()
						vim.wo.winfixbuf = true
						vim.bo.buflisted = false
						vim.bo.buftype = "nofile"
						vim.bo.swapfile = false
						vim.bo.bufhidden = "wipe"
						vim.notify("post_open_hook triggered!", vim.log.levels.INFO)
					end,
				},
			},
		},
	},
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
		},
		-- uncomment the following line to load hub lazily
		--cmd = "MCPHub",  -- lazy load
		build = "yarn global add mcp-hub@latest", -- Installs required mcp-hub npm module
		-- uncomment this if you don't want mcp-hub to be available globally or can't use -g
		-- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
		config = function()
			require("mcphub").setup()
		end,
	},
	{
		"sindrets/diffview.nvim",
		opts = {
			view = {
				merge_tool = {
					layout = "diff3_mixed",
				},
			},
		},
	},
}
