require "nvchad.options"

-- add yours here!

vim.opt.relativenumber = true
vim.o.cursorlineopt = 'both'
vim.o.timeout = true
vim.o.timeoutlen = 50
vim.o.shortmess = vim.o.shortmess .. 'I'

-- -- toggle inlay_hint off in insert mode
-- vim.api.nvim_create_autocmd("InsertEnter", {
--   desc = "Disable lsp.inlay_hint when in insert mode",
--   callback = function(args)
--     local filter = { bufnr = args.buf }
--     local inlay_hint = vim.lsp.inlay_hint
--     if inlay_hint.is_enabled(filter) then
--       inlay_hint.enable(false, filter)
--       vim.api.nvim_create_autocmd("InsertLeave", {
--         once = true,
--         desc = "Re-enable lsp.inlay_hint when leaving insert mode",
--         callback = function()
--           inlay_hint.enable(true, filter)
--         end,
--       })
--     end
--   end,
-- })
