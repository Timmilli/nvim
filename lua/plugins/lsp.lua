return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		-- Mason must be loaded before its dependents so we need to set it up here.
		-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
		{ "mason-org/mason.nvim", opts = {} },
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },

		-- Allows extra capabilities provided by blink.cmp
		"saghen/blink.cmp",
	},
	config = function()
		---------------------------------------------------------------------------
		-- LSP ATTACH KEYMAPS & UI
		---------------------------------------------------------------------------
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				-- Helper to create keymaps
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Actual lsp-related keymaps
				map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
				map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
				map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
				map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

				-- Detach function called upon exit
				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
					end,
				})

				-- The following code creates a keymap to toggle inlay hints in your
				-- code, if the language server you are using supports them
				if client and client.server_capabilities.inlayHintProvider then
					map("<leader>th", function()
						vim.lsp.inlay_hint.toggle({ bufnr = event.buf })
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		---------------------------------------------------------------------------
		-- DIAGNOSTICS
		---------------------------------------------------------------------------
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			virtual_text = {
				source = "if_many",
				spacing = 2,
			},
		})

		---------------------------------------------------------------------------
		-- CAPABILITIES
		---------------------------------------------------------------------------
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		---------------------------------------------------------------------------
		-- MASON & LSP SERVERS (NEOVIM 0.11.6)
		---------------------------------------------------------------------------

		local servers = {
			-- Lua LSP
			"lua-language-server",
			"stylua",
			-- C LSP
			"clangd",
			-- Python LSP
			"basedpyright",
			"ruff",
		}

		require("mason-tool-installer").setup({
			ensure_installed = servers,
		})

		vim.lsp.enable(servers)
	end,
}
