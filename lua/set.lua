-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- for neo-tree
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true

-- Enable mouse mode, can be useful for resizing splits for example!
-- vim.o.mouse = "a"

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Add a confirmation before leaving unsaved file
vim.o.confirm = true

-- More helpers
vim.o.undofile = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true

-- For highlight interaction
vim.opt.hls = true
vim.opt.incsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- For line above 80 characters
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- For spelling mistakes
vim.opt.spelllang = { "en_us", "fr" }
vim.opt.spell = true
