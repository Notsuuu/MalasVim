return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- Konfigurasi default Noice sudah otomatis mengaktifkan cmdline melayang
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true, -- Gunakan cmdline klasik untuk pencarian (opsional, ganti false jika mau melayang juga)
      command_palette = true, -- Posisi cmdline melayang di tengah
      long_message_to_split = true, 
      inc_rename = false, 
      lsp_doc_border = false, 
    },
  },
  dependencies = {
    -- Noice butuh dua plugin ini agar bisa merender tampilan melayangnya
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  }
}
