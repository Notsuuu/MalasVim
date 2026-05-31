-- ~/.config/nvim/lua/plugins/lsp.lua

return {

  -- 🎨 1. SYNTAX HIGHLIGHTING: Treesitter (SAFE MODE)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
      
      if not status_ok then
        vim.notify("Treesitter sedang disiapkan, silakan tunggu sebentar...")
        return
      end

      treesitter.setup({
        ensure_installed = {
          "c", "lua", "vim", "vimdoc", "javascript", "typescript",
          "python", "php", "html", "css", "json"
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- 2. MANAJER INSTALASI (Mason)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },

  -- 3. JEMBATAN LSP KE NEOVIM
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- 🛠️ FIX: Sembunyikan warning saat startup
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      
      -- 🛠️ FIX: Cara setel otomatis (Bypass error framework deprecated)
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clangd", "intelephense", "ts_ls", "html", "cssls" },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({})
          end,
        },
      })

      -- Shortcut LSP
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Info" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
    end,
  },

  -- 4. AUTOCOMPLETE
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- 🛠️ FIX: Diload HANYA saat kamu mulai ngetik
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  -- 5. AI ASSISTANT (Copilot)
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "InsertEnter",
  },

  -- 6. REST API CLIENT (Kulala)
  {
    "mistweaverco/kulala.nvim",
    opts = {},
    keys = {
      { "<leader>rr", "<cmd>lua require('kulala').run()<cr>", desc = "Run REST Request" },
    },
  },

}
