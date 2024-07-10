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
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '*',
    lazy = false, -- This plugin is already lazy
    init = function()
      vim.g.rustaceanvim = {
        server = {
          settings = {
            ["rust-analyzer"] = {
              inlayHints = {
                bindingModeHints = {
                  enable = false,
                },
                chainingHints = {
                  enable = true,
                },
                closingBraceHints = {
                  enable = true,
                  minLines = 25,
                },
                closureReturnTypeHints = {
                  enable = "never",
                },
                lifetimeElisionHints = {
                  enable = "never",
                  useParameterNames = false,
                },
                maxLength = 25,
                parameterHints = {
                  enable = true,
                },
                reborrowHints = {
                  enable = "never",
                },
                renderColons = true,
                typeHints = {
                  enable = true,
                  hideClosureInitialization = false,
                  hideNamedConstructor = false,
                },
              },
            },
          },
        },
      }
    end
  },

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

  { 'mfussenegger/nvim-dap' },

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
      -- Navigation
      {
        ']c',
        function()
          local gitsigns = require 'gitsigns'
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end,
        desc = "Next change"
      },
      {
        '[c',
        function()
          local gitsigns = require 'gitsigns'
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end,
        desc = "Previous change"
      },

      -- Actions
      { '<leader>hs', ':Gitsigns stage_hunk<CR>',                             mode = 'n', desc = "Stage hunk" },
      { '<leader>hs', ':Gitsigns stage_hunk<CR>',                             mode = 'v', desc = "Stage hunk" },
      { '<leader>hr', ':Gitsigns reset_hunk<CR>',                             mode = 'n', desc = "Reset hunk" },
      { '<leader>hr', ':Gitsigns reset_hunk<CR>',                             mode = 'v', desc = "Reset hunk" },
      { '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>',                       mode = 'n', desc = "Stage buffer" },
      { '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>',                    mode = 'n', desc = "Undo stage hunk" },
      { '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>',                       mode = 'n', desc = "Reset buffer" },
      { '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>',                       mode = 'n', desc = "Preview hunk" },
      { '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', mode = 'n', desc = "Blame line (full)" },
      { '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>',          mode = 'n', desc = "Blame line" },
      { '<leader>hd', '<cmd>Gitsigns diffthis<CR>',                           mode = 'n', desc = "Diff current buffer" },
      { '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>',         mode = 'n', desc = "Diff current buffer" },
      { '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>',                     mode = 'n', desc = "Toggle deleted" },

      -- Text object
      { 'ih',         ':<C-U>Gitsigns select_hunk<CR>',                       mode = 'o', desc = "Select hunk" },
      { 'ih',         ':<C-U>Gitsigns select_hunk<CR>',                       mode = 'x', desc = "Select hunk" },
    }
  },
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>ga", "<cmd>Git blame<cr>", desc = "Annotate" },
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
  },

  {
    "nvim-neotest/neotest",
    lazy = false,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "mrcjkb/rustaceanvim",
    },
    init = function()
      require('neotest').setup {
        adapters = {
          require('rustaceanvim.neotest'),
          require('neotest-jest')({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.json",
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-vitest")
        },
      }
    end,
    keys = {
      { "<leader>tt", "<cmd>lua require'neotest'.run.run()<cr>",                                    desc = "Run nearest test" },
      { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",                desc = "Run all tests in file" },
      { "<leader>tl", "<cmd>lua require('neotest').run.run_last()<cr>",                             desc = "Run Last Test" },
      { "<leader>tL", '<cmd>lua require("neotest").run.run_last({ strategy = "dap" })<cr>',         desc = "Debug last test" },
      { "<leader>tw", "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>", desc = "Run watch", },
    },
  }
}
