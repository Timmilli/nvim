-- extends $VIMPLUG/nvim-lspconfig/lsp/basedpyright.lua
return {
	root_markers = { "pyproject.toml", "ruff.toml", ".git" },
	settings = {
		python = {
			-- Always use the current python in $PATH (the current conda/virtualenv).
			-- NOTE: python.pythonPath (not basedpyright.pythonPath), see the basedpyright docs
			pythonPath = vim.fn.exepath("python3"),
		},
		basedpyright = {
			-- in favor of ruff's import organizer
			disableOrganizeImports = true,
			-- use auto-import (which is also by default)
			autoImportCompletions = true,

			-- NOTE: the "discouraged settings" here will be ignored if the project root contains
			-- either a pyproject.toml ([tool.pyright]) or pyrightconfig.json configuration file.
			-- https://docs.basedpyright.com/latest/configuration/config-files/#overriding-language-server-settings
			-- https://docs.basedpyright.com/latest/configuration/language-server-settings/#discouraged-settings
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				typeCheckingMode = "standard",

				extraPaths = {
					"./python",
					"./typings",
				},

				stubPath = "./typings",

				useLibraryCodeForTypes = true,
			},

			inlayHints = {
				callArgumentNames = true,
				callArgumentNamesMathcing = false,
				functionReturnTypes = true,
				variableTypes = true,
				genericTypes = true, --(override)
			},
		},
	},
}
