local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	show_help = true, -- show help message on the command line when the popup is visible
}

-- Set up which-key for nvim-tree
local function yank_nvim_tree_rel_path()
	local node = require("nvim-tree.api").tree.get_node_under_cursor()
	if node then
		local path = vim.fn.fnamemodify(node.absolute_path, ":.")
		vim.fn.setreg("+", path)
		print("Yanked to clipboard: " .. path)
	else
		print("No file selected in nvim-tree")
	end
end

local multi_grep = require("config.telescope.multigrep")

local mappings = {
	-- Telescope, diagnostics, git, and diff (normal mode)
	{
		mode = "n",
		{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files", icon = "📂", nowait = true },
		{ "<leader>F", "<cmd>Telescope live_grep<cr>", desc = "Live Grep", icon = "🔤", nowait = true },
		{ "<leader>M", multi_grep.live_multigrep, desc = "Multi Grep", icon = "🔎", nowait = true },
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree", icon = "🌳", nowait = true },
		{ "<leader>p", yank_nvim_tree_rel_path, desc = "Yank Relative Path", icon = "📝", nowait = true },
		{ "<leader>D", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Open Diagnostics", nowait = true },
		{ "<leader>t", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Diagnostics for current buffer", nowait = true },
		{ "<leader>gi", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Preview hunk inline", nowait = true },
		{ "<leader>m", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Render Markdown", nowait = true },
		{ "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview", nowait = true },
		{ "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview", nowait = true },
	},

	-- Opencode (leader + o)
	{
		mode = { "n", "x", "t" },
		{ "<leader>o", group = "Opencode" },
		{
			"<leader>oa",
			function()
				require("opencode").ask("@this: ", { submit = true })
			end,
			desc = "Ask (submit)",
			mode = { "n", "x" },
			nowait = true,
			silent = true,
		},
		{
			"<leader>ox",
			function()
				require("opencode").select()
			end,
			desc = "Execute selection",
			mode = { "n", "x" },
			nowait = true,
			silent = true,
		},
		{
			"<leader>ot",
			function()
				require("opencode").toggle()
			end,
			desc = "Toggle opencode",
			mode = { "n", "t" },
			nowait = true,
			silent = true,
		},
		{
			"<leader>og",
			function()
				vim.notify("Use `go`/`goo` to add ranges to opencode.", vim.log.levels.INFO)
			end,
			desc = "Operator (`go`/`goo`)",
			nowait = true,
			silent = true,
		},
		{
			"<leader>os",
			function()
				require("opencode").command("session.half.page.up")
			end,
			desc = "Scroll up (<S-C-u>)",
			nowait = true,
			silent = true,
		},
		{
			"<leader>od",
			function()
				require("opencode").command("session.half.page.down")
			end,
			desc = "Scroll down (<S-C-d>)",
			nowait = true,
			silent = true,
		},
		{
			"<leader>o+",
			function()
				vim.notify("Use `+` to increment (alias for <C-a>).", vim.log.levels.INFO)
			end,
			desc = "Increment alias (`+`)",
			nowait = true,
			silent = true,
		},
		{
			"<leader>o-",
			function()
				vim.notify("Use `-` to decrement (alias for <C-x>).", vim.log.levels.INFO)
			end,
			desc = "Decrement alias (`-`)",
			nowait = true,
			silent = true,
		},
	},
}

return {
	"folke/which-key.nvim",
	config = function()
		local status_ok, which_key = pcall(require, "which-key")
		if not status_ok then
			return
		end

		which_key.setup(setup)
		which_key.add(mappings)
	end,
}
