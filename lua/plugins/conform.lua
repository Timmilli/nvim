return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = true,
		format_on_save = function(bufnr)
			local disable_filetypes = {}
			local ft = vim.bo[bufnr].filetype
			if disable_filetypes[ft] then
				return nil
			end
			-- For C/C++, never fall back to LSP — clang-format handles it directly
			if ft == "c" or ft == "cpp" then
				return { timeout_ms = 500, lsp_format = "never" }
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			tex = { "latexindent" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use 'stop_after_first' to run the first available formatter from the list
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
		},
	},
}
