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
	{
		"<leader>f",
		"<cmd>Telescope find_files<cr>",
		icon = "📂",
		desc = "Find Files",
		nowait = true,
		remap = false,
	},
	{
		"<leader>F",
		"<cmd>Telescope live_grep<cr>",
		icon = "🔤",
		desc = "Live Grep",
		nowait = true,
		remap = false,
	},
	{
		"<leader>M",
		multi_grep.live_multigrep,
		icon = "🔎",
		desc = "Multi Grep",
		nowait = true,
		remap = false,
	},
	{
		"<leader>e",
		":NvimTreeToggle<CR>",
		icon = "🌳",
		desc = "Toggle NvimTree",
		nowait = true,
		remap = false,
	},
	{ "<leader>p", yank_nvim_tree_rel_path, icon = "📝", desc = "Yank Relative Path", nowait = true, remap = false },
	{
		"<leader>D",
		"<cmd>lua vim.diagnostic.open_float()<cr>",
		desc = "Open Diagnostics",
		nowait = true,
		remap = false,
	},
	{
		"<leader>t",
		"<cmd>lua vim.diagnostic.setloclist()<cr>",
		desc = "Diagnostics for current buffer",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gi",
		"<cmd>Gitsigns preview_hunk_inline<cr>",
		desc = "Preview hunk inline",
		nowait = true,
		remap = false,
	},
	{
		"<leader>m",
		"<cmd>RenderMarkdown toggle<cr>",
		desc = "Toggle Render Markdown",
		nowait = true,
		remap = false,
	},
	{
		"<leader>do",
		"<cmd>DiffviewOpen<cr>",
		desc = "Open Diffview",
		nowait = true,
		remap = false,
	},
	{
		"<leader>dc",
		"<cmd>DiffviewClose<cr>",
		desc = "Close Diffview",
		nowait = true,
		remap = false,
	},
	{ "<leader>c", group = "AI / CodeCompanion" }, -- header in which-key
	{ "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat", mode = { "n", "v" } },
	{ "<leader>ca", "<cmd>CodeCompanionActions<cr>", desc = "Actions", mode = { "n", "v" } },
	{ "<leader>cs", "<cmd>CodeCompanionChat Add<cr>", desc = "Add Selection", mode = "v" },
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
