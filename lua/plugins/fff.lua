return {
	"dmtrKovalenko/fff.nvim",
	build = function()
		require("fff.download").download_or_build_binary()
	end,
	lazy = false,
	opts = {
		prompt = "❯ ",
		title = "FFFiles",
		max_results = 100,
		layout = {
			height = 0.8,
			width = 0.8,
			prompt_position = "bottom",
			preview_position = "right",
			preview_size = 0.5,
			show_scrollbar = true,
			path_shorten_strategy = "middle_number",
		},
		preview = {
			enabled = true,
			max_size = 10 * 1024 * 1024,
			line_numbers = true,
			wrap_lines = false,
			filetypes = {
				svg = { wrap_lines = true },
				markdown = { wrap_lines = true },
			},
		},
		frecency = {
			enabled = true,
			db_path = vim.fn.stdpath("cache") .. "/fff_nvim",
		},
		history = {
			enabled = true,
			db_path = vim.fn.stdpath("data") .. "/fff_queries",
			min_combo_count = 3,
			combo_boost_score_multiplier = 100,
		},
		git = {
			status_text_color = false,
		},
		grep = {
			max_file_size = 10 * 1024 * 1024,
			max_matches_per_file = 100,
			smart_case = true,
			time_budget_ms = 150,
			modes = { "plain", "regex", "fuzzy" },
		},
		debug = {
			enabled = false,
			show_scores = false,
		},
	},
	keys = {
		{
			"<leader>f",
			function()
				require("fff").find_files()
			end,
			desc = "Find files",
		},
		{
			"<leader>F",
			function()
				require("fff").live_grep()
			end,
			desc = "Live grep",
		},
	},
}
