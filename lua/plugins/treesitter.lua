return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then return end

    configs.setup({
      ensure_installed = { 
        "c", "lua", "vim", "vimdoc", "query", 
        "html", "php", "css", "javascript" 
      },
      highlight = { 
        enable = true,
        disable = { "blade" }, -- Menyuruh Treesitter lepas tangan dari file Blade
      },
      indent = { enable = true },
    })
  end,
}
