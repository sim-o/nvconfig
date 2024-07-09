local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- check server names in https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  html = {},
  clangd = {},
  cssls = {},
  dartls = {},
  gopls = {},
  jsonnet_ls = {},
  kotlin_language_server = {
    settings = {
      kotlin = {
        hints = {
          typeHints = true,
          parameterHints = true,
          chaineHints = true,
        },
      },
    }
  },
  lua_ls = {},
  lemminx = {},
  marksman = {},
  rust_analyzer = {},
  tailwindcss = {},
  tsserver = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  yamlls = {},
}

-- lsps with default config
for lsp, opts in pairs(servers) do
  opts.on_attach = on_attach
  opts.on_init = on_init
  opts.capabilities = capabilities
  lspconfig[lsp].setup(opts)
end
