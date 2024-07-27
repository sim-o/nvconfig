return {
  {
    "L3MON4D3/LuaSnip",
    init = function()
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
  },
}
