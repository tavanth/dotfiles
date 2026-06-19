local opt = vim.opt

opt.guicursor = "i:block"
opt.clipboard = "unnamed"
opt.termguicolors = true
opt.ignorecase = true
opt.swapfile = false
opt.autoindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.relativenumber = true
opt.numberwidth = 2
opt.wrap = true
opt.scrolloff = 8
opt.undofile = true
opt.completeopt = { "menuone", "popup", "noinsert" }
opt.winborder = "double"
opt.signcolumn = "yes:1"
opt.list = true
vim.cmd.filetype("plugin indent on")
vim.cmd.colorscheme("kanso")
