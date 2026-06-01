return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]], -- Jalan pintas: Ctrl + \
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "float", -- Mode terminal melayang
      float_opts = {
        border = "curved", -- Gaya pinggiran melengkung
        winblend = 0,
      },
    })
  end,
}
