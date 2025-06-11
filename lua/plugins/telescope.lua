return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
	},
	config = function()
		local status_ok, telescope = pcall(require, "telescope")
		if not status_ok then
			return
		end

		telescope.load_extension("media_files")

		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "smart" },
				-- configure to use ripgrep
				vimgrep_arguments = {
					"rg",
					"--follow", -- Follow symbolic links
					"--hidden", -- Search for hidden files
					"--no-ignore", -- Don't ignore files
					"--no-heading", -- Don't group matches by each file
					"--with-filename", -- Print the file path with the matched lines
					"--line-number", -- Show line numbers
					"--column", -- Show column numbers
					"--smart-case", -- Smart case search

					-- Exclude some patterns from search
					"--glob=!**/.git/*",
					"--glob=!**/.idea/*",
					"--glob=!**/.vscode/*",
					"--glob=!**/build/*",
					"--glob=!**/dist/*",
					"--glob=!**/yarn.lock",
					"--glob=!**/package-lock.json",
					"--glob=!**/node_modules/*",
				},

				mappings = {
					i = {
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,

						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,

						["<C-c>"] = actions.close,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,

						["<CR>"] = actions.select_default,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
					},

					n = {
						["<esc>"] = actions.close,
						["<CR>"] = actions.select_default,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,

						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
						["H"] = actions.move_to_top,
						["M"] = actions.move_to_middle,
						["L"] = actions.move_to_bottom,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,
						["gg"] = actions.move_to_top,
						["G"] = actions.move_to_bottom,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["?"] = actions.which_key,
					},
				},
			},

			pickers = {
				find_files = {
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--no-ignore",
						"--glob=!**/.git/*",
						"--glob=!**/.idea/*",
						"--glob=!**/.vscode/*",
						"--glob=!**/build/*",
						"--glob=!**/dist/*",
						"--glob=!**/yarn.lock",
						"--glob=!**/package-lock.json",
						"--glob=!**/node_modules",
					},
				},
				grep_string = {
					additional_args = { "--hidden" },
				},
				live_grep = {
					theme = "ivy",
					additional_args = { "--hidden" },
				},
				lsp_references = {
					theme = "ivy",
				},
			},

			extensions = {
				media_files = {
					-- filetypes whitelist
					-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
					filetypes = { "png", "webp", "jpg", "jpeg" },
					find_cmd = "rg", -- find command (defaults to `fd`)
				},
			},
		})
		-- This will load fzy_native and have it override the default file sorter
		telescope.load_extension("fzf")
		-- For other modules to use
		telescope.load_extension("ui-select")
		telescope.load_extension("harpoon")
	end,
}
