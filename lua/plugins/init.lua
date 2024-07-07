return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
    keys = {
      { "<leader>cr", "<Cmd>lua vim.lsp.buf.rename()<CR>",      desc = "Rename" },
      { "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action..." },
    },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },

  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local config = {
        cmd = { "/opt/homebrew/bin/jdtls" },
        root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
        completion = {
          filteredTypes = {
            "com.sun.*",
            "io.micrometer.shaded.*",
            "java.awt.*",
            "jdk.*", "sun.*",
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
        }
      }
      require("jdtls").start_or_attach(config)
      vim.keymap.set(
        "n",
        "<leader>oi",
        "<Cmd>lua require'jdtls'.organize_imports()<CR>",
        { desc = "Organise imports" }
      )
      vim.keymap.set(
        "n",
        "<leader>ov",
        "<Cmd>lua require'jdtls'.extract_variable()<CR>",
        { desc = "Extract variable" }
      )
      vim.keymap.set(
        "n",
        "<leader>oc",
        "<Cmd>lua require'jdtls'.extract_constant()<CR>",
        { desc = "Extract constant" }
      )
      vim.keymap.set(
        "n",
        "<leader>om",
        "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>",
        { desc = "Extract method" }
      )
    end,
  },

  {
    "ggandor/leap.nvim",
    dependencies = {
      "tpope/vim-repeat",
    },
    init = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "prettierd",
        "typescript-language-server",
        "tailwind-language-server",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "typescript",
        "javascript",
        "java",
        "kotlin",
        "yaml",
        "json",
        "rust",
      },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  {
    'nvim-telescope/telescope-ui-select.nvim',
    lazy = false,
    init = function()
      require("telescope").load_extension("ui-select")
    end,
  }
}
