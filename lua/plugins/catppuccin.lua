return { -- You can easily change to a different colorscheme.
	-- Change the name of the colorscheme plugin below, and then
	-- change the command in the config to whatever the name of that colorscheme is.
	--
	-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
	"catppuccin/nvim",
	dependencies = {
		{ "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
	},
	config = function()
		require("catppuccin").setup({
			name = "catppuccin",
			priority = 1000,
			transparent_background = true,
			float = {
				transparent = true,
				solid = true,
			},
		})

		-- Load the colorscheme here.
		vim.cmd.colorscheme("catppuccin-macchiato")
		require("lualine").setup()
	end,
}
