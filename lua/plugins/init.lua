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
    config = true,
    opts = {
      autocmd = { enable = false }
    },
    keys = {
      { "<leader>ih", "<cmd>InlayHintsToggle<cr>", desc = "Toggle inlay hints" },
    }
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
    "mbbill/undotree",
    keys = {
      { "<leader><F5>", "<cmd>UndotreeToggle<cr>", desc = "Undo tree" }
    }
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
      { "<M-x>", desc = "Toggle tshjkl" },
    }
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    config = true,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    init = function()
      local config = {
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Select outer function" },
              ["if"] = { query = "@function.inner", desc = "Select inner function" },
              ["ac"] = { query = "@class.outer", desc = "Select outer class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V',  -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            -- include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = { query = "@function.outer", desc = "Next function start" },
              ["]]"] = { query = "@class.outer", desc = "Next class start" },

              -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]M"] = { query = "@function.outer", desc = "Next function end" },
              ["]["] = { query = "@class.outer", desc = "Next class end" },
            },
            goto_previous_start = {
              ["[m"] = { query = "@function.outer", desc = "Previous function start" },
              ["[["] = { query = "@class.outer", desc = "Previous class start" },
            },
            goto_previous_end = {
              ["[M"] = { query = "@function.outer", desc = "Previous function end" },
              ["[]"] = { query = "@class.outer", desc = "PRevious class end" },
            },
          },
        },
      }
      require 'nvim-treesitter.configs'.setup(config)
    end
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
    "mfussenegger/nvim-dap",
    lazy = false,
    keys = {
      { "<F7>",  "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Debug - toggle breakpoint" },
      { "<F8>",  "<cmd>lua require'dap'.continue()<cr>",          desc = "Debug - continue" },
      { "<F9>",  "<cmd>lua require'dap'.step_over()<cr>",         desc = "Debug - step over" },
      { "<F10>", "<cmd>lua require'dap'.step_into()<cr>",         desc = "Debug - step into" },
      { "<F11>", "<cmd>lua require'dap'.repl.open()<cr>",         desc = "Debug - inspect repl" },
      { "<F12>", "<cmd>help dap-widgets<cr>",                     desc = "Debug - inspect widget ui" }
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
      "rcasia/neotest-java",
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
          require("neotest-vitest"),
          require("neotest-java")({
            ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
            junit_jar = nil,        -- default: .local/share/nvim/neotest-java/junit-platform-console-standalone-[version].jar
          })
        },
      }
    end,
    keys = {
      { "<leader>tt", "<cmd>lua require'neotest'.run.run()<cr>",                                    desc = "Run nearest test" },
      { "<leader>tT", '<cmd>lua require("neotest").run.run({strategy = "dap"})<cr>',                desc = "Run nearest test in debugger" },
      { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",                desc = "Run all tests in file" },
      { "<leader>tl", "<cmd>lua require('neotest').run.run_last()<cr>",                             desc = "Run Last Test" },
      { "<leader>tL", '<cmd>lua require("neotest").run.run_last({ strategy = "dap" })<cr>',         desc = "Debug last test" },
      { "<leader>tw", "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>", desc = "Run watch", },
    },
  }
}
