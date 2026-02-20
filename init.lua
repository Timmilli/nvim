--[[

  Based on [Kickstart](https://github.com/nvim-lua/kickstart.nvim)

]]

-- Set <space> as the <leader> key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("set")

require("remap")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]

require("lazy").setup({
	-- Lsp needs to be first
	require("plugins.lsp"),

	-- Then whatever
	require("plugins.autocompletion"),
	require("plugins.autopairs"),
	require("plugins.blink"),
	require("plugins.catppuccin"),
	require("plugins.comments"),
	require("plugins.conform"),
	require("plugins.gitsigns"),
	require("plugins.indent_line"),
	require("plugins.lint"),
	require("plugins.luasnip"),
	require("plugins.markdown-preview"),
	require("plugins.neo-tree"),
	require("plugins.precommit"),
	require("plugins.telescope"),
	require("plugins.treesiter"),
	require("plugins.uv"),
	require("plugins.vimtex"),
	require("plugins.whichkey"),
})
