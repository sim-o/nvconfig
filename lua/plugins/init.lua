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
    "MysticalDevil/inlay-hints.nvim",
    event = "LspAttach",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("inlay-hints").setup()
    end
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
      local jdtls = require 'jdtls'
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
        },
        settings = {
          java = {
            autobuild = { enabled = false },
            contentProvider = { preferred = 'fernflower' },
            saveActions = {
              organizeImports = true,
            },
            inlayHints = {
              parameterNames = {
                enabled = "all",
                exclusions = { "this" },
              },
            },
            signatureHelp = { enabled = true },
          }
        },
      }
      jdtls.start_or_attach(config)
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
        "markdown",
        "markdown_inline",
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
    'gsuuon/tshjkl.nvim',
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
    opts = {
      keymaps = {
        toggle = '<M-x>',
      },
    },
    keys = {
      { "<M-x>", desc = "Toggle tshjkl" }
    }
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    config = true,
  },

  {
    "stevearc/aerial.nvim",
    opts = {
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    },
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    keys = {
      { "<leader>a",  "<Cmd>AerialToggle<CR>",                                        desc = "Aerial toggle" },
      { "<leader>fl", "<Cmd>lua require('telescope').extensions.aerial.aerial()<CR>", desc = "Telescope aerial" },
      { "}",          "<Cmd>AerialNext<CR>",                                          desc = "Aerial next" },
      { "{",          "<Cmd>AerialPrev<CR>",                                          desc = "Aerial previous" },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Telescope keymaps" },
    }
  },

  {
    "lewis6991/gitsigns.nvim",
    keys = {
      { "<leader>gl", "<cmd>lua require'gitsigns'.toggle_current_line_blame()<cr>", desc = "Annotate" },
    }
  },

  {
    'nvim-telescope/telescope-ui-select.nvim',
    dependencies = { "nvim-telescope/telescope.nvim" },
    init = function()
      require("telescope").load_extension("ui-select")
    end,
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp"
    },
    opts = {
      workspaces = {
        { name = "notes", path = "~/Docs/Obsidian" }
      },
      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
      },
    }
  }
}
