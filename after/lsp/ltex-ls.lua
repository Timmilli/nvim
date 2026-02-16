-- extends $VIMPLUG/nvim-lspconfig/lsp/ltex.lua
---@type vim.lsp.Config

return {
	filetypes = { "markdown", "tex", "gitcommit" },
	settings = {
		-- https://valentjn.github.io/ltex/settings.html
		ltex = {},
	},
}
