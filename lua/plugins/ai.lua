return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("codecompanion").setup({
      system_prompt = "Kamu adalah asisten AI ahli programming untuk Neovim. Kamu HARUS SELALU berkomunikasi, menjelaskan kode, dan menjawab pertanyaan menggunakan Bahasa Indonesia yang baik, santai, dan mudah dipahami. Jangan pernah menggunakan bahasa Inggris untuk merespons percakapan.",
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = {
                default = "gemini-1.5-flash",
              },
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = "gemini" },
        inline = { adapter = "gemini" },
      },
    })

    -- Jalan Pintas (Keymaps)
    vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle AI Chat" })
    vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "AI Actions" })
    vim.keymap.set("v", "<leader>ad", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add code to AI Chat" })
  end,
}
