require "nvchad.options"

-- add yours here!

vim.opt.relativenumber = true
vim.o.cursorlineopt = 'both'
vim.o.timeout = true
vim.o.timeoutlen = 50
vim.o.shortmess = vim.o.shortmess .. 'I'
vim.o.conceallevel = 2

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
