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
		local telescope = require("telescope")
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
					-- Python virtual environment patterns
					"--glob=!**/.venv/*", -- Python virtual environment
					"--glob=!**/.env/*", -- Alternative venv name
					"--glob=!**/venv/*", -- Another common venv name
					"--glob=!**/__pycache__/*", -- Python cache
					"--glob=!**/*.pyc", -- Python compiled files
					"--glob=!**/.pytest_cache/*", -- Pytest cache
					"--glob=!**/.coverage", -- Coverage files
					"--glob=!**/.tox/*", -- Tox directories
					"--glob=!**/.mypy_cache/*", -- MyPy cache
					"--glob=!**/uv.lock", -- UV lock file
					-- System files
					"--glob=!**/.DS_Store", -- macOS files
					"--glob=!**/Thumbs.db", -- Windows files
					"--glob=!**/.ipynb_checkpoints/*", -- Jupyter checkpoints
				},

				file_ignore_patterns = {
					-- Version control
					"%.git/",

					-- Python
					"%.venv/",
					"venv/",
					"%.env/",
					"__pycache__/",
					"%.pyc$",
					"%.pyo$",
					"%.pyd$",
					"%.pytest_cache/",
					"%.coverage",
					"%.tox/",
					"%.mypy_cache/",

					-- Node.js
					"node_modules/",
					"%.npm/",
					"yarn%.lock",
					"package%-lock%.json",

					-- Build artifacts
					"build/",
					"dist/",
					"target/",
					"%.o$",
					"%.so$",
					"%.dll$",
					"%.exe$",

					-- IDE/Editor files
					"%.idea/",
					"%.vscode/",
					"%.swp$",
					"%.swo$",
					"%.tmp$",

					-- OS files
					"%.DS_Store",
					"Thumbs%.db",

					-- UV/Rust package manager
					"uv%.lock",

					-- Jupyter
					"%.ipynb_checkpoints/",

					-- Common log files
					"%.log$",
					"%.out$",
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
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-l>"] = actions.complete_tag,
						["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
					},

					n = {
						["<esc>"] = actions.close,
						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

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
						"--glob=!**/node_modules/*",
						"--glob=!**/target/*", -- Rust/Java build dir
						"--glob=!**/*.pyo", -- Python optimized
						"--glob=!**/*.pyd", -- Python extension
						"--glob=!**/.pytest_cache/*",
						"--glob=!**/.coverage",
						"--glob=!**/.tox/*",
						"--glob=!**/.mypy_cache/*",
						"--glob=!**/uv.lock",
						"--glob=!**/.DS_Store",
						"--glob=!**/Thumbs.db",
						"--glob=!**/.ipynb_checkpoints/*",
						"--glob=!**/*.log",
						"--glob=!**/*.tmp",
						"--glob=!**/*.swp",
						"--glob=!**/*.swo",
					},
				},
				file_ignore_patterns = {
					"%.git/",
					"%.venv/",
					"venv/",
					"%.env/",
					"__pycache__/",
					"%.pyc$",
					"%.pyo$",
					"%.pyd$",
					"node_modules/",
					"%.npm/",
					"build/",
					"dist/",
					"target/",
					"%.idea/",
					"%.vscode/",
					"%.ipynb_checkpoints/",
					"uv%.lock",
				},
				grep_string = {
					additional_args = { "--hidden" },
				},
				live_grep = {
					theme = "ivy",
					additional_args = { "--hidden" },
					file_ignore_patterns = {
						"%.venv/",
						"venv/",
						"%.env/",
						"__pycache__/",
						"%.pyc$",
						"node_modules/",
						"%.git/",
						"build/",
						"dist/",
						"%.ipynb_checkpoints/",
					},
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

		telescope.load_extension("fzf")
		telescope.load_extension("media_files")
		telescope.load_extension("ui-select")
		telescope.load_extension("harpoon")
	end,
}
