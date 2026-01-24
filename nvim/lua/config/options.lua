local opt = vim.opt

-- tab/indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.shiftround = true
opt.autoindent = true
opt.cindent = true
opt.smartindent = true
opt.copyindent = true
opt.wrap = false -- long line no wrap
-- opt.breakindent = true -- wrapped line indent

-- search
opt.incsearch = true

-- visual
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = "100"
opt.signcolumn = "yes" -- always show sign column

-- windows
opt.splitright = true

-- etc
opt.backspace = { "indent", "eol", "start" }
opt.encoding = "UTF-8"
opt.cmdheight = 1 -- command line height
opt.scrolloff = 8
opt.mouse:append("a")

-- undo/backup
opt.swapfile = false -- no swapfile
opt.backup = false -- no backup file
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.undofile = true

opt.clipboard = "unnamedplus" -- use system clipboard
