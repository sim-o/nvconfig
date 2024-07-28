return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      {
        "<leader>Re",
        "<cmd>lua require'kulala'.set_selected_env(nil)<cr>",
        desc = "Select environment",
      },
    },
  },
}
