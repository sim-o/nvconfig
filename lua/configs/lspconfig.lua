local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- check server names in https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  "html",
  "clangd",
  "cssls",
  "lua_ls",
  "lemminx",
  -- "java_language_server",
  -- "kotlin_language_server",
  "marksman",
  "tailwindcss",
  "tsserver",
  "yamlls",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end
