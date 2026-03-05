return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		local js_ts_filetypes = {
			typescript = true,
			javascript = true,
			typescriptreact = true,
			javascriptreact = true,
		}

		local function resolve_linter(name)
			local linter = lint.linters[name]
			if not linter then
				return nil
			end
			if type(linter) == "function" then
				linter = linter()
			end
			return linter
		end

		local function resolve_cmd(linter)
			if not linter then
				return nil
			end

			local cmd = linter.cmd
			if type(cmd) == "function" then
				local ok, resolved = pcall(cmd)
				if ok then
					cmd = resolved
				else
					return nil
				end
			end

			if type(cmd) ~= "string" or cmd == "" then
				return nil
			end

			return cmd
		end

		local function first_available_linter(names)
			for _, name in ipairs(names) do
				local cmd = resolve_cmd(resolve_linter(name))
				if cmd and vim.fn.executable(cmd) == 1 then
					return name
				end
			end

			return nil
		end

		lint.linters_by_ft = {
			markdown = { "vale" },
			c = { "cpplint" },
			go = { "golangci-lint" },
			typescript = { "oxlint", "eslint_d" },
			javascript = { "oxlint", "eslint_d" },
			typescriptreact = { "oxlint", "eslint_d" },
			javascriptreact = { "oxlint", "eslint_d" },
			lua = { "luacheck" },
			python = { "ruff" },
			sh = { "shellcheck" },
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function()
				local filetype = vim.bo.filetype
				if js_ts_filetypes[filetype] then
					local linters = lint.linters_by_ft[filetype] or {}
					local selected = first_available_linter(linters)
					if selected then
						lint.try_lint(selected)
						return
					end
				end

				lint.try_lint()
			end,
		})
	end,
}
