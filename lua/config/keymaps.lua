-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("c", "<C-b>", "<Left>")
map("c", "<C-f>", "<Right>")
map("c", "<A-b>", "<S-Left>")
map("c", "<A-f>", "<S-Right>")
map("c", "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")
map("c", "<C-p>", "<Up>")
map("c", "<C-d>", "<Del>")
map("c", "<C-n>", "<Down>")
map("c", "<C-q>", "<C-c>q:dd")
