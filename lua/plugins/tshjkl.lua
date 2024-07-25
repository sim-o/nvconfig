return {
  {
    "gsuuon/tshjkl.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
    opts = {
      keymaps = {
        toggle = "<M-x>",
      },
    },
    keys = {
      { "<M-x>", desc = "Toggle tshjkl" },
    },
  },
}
