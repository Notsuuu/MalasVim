-- ~/.config/nvim/lua/plugins/editor.lua

return {

	-- 1. PENCARIAN FILE (Telescope)
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Cari File" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Cari Kata (Live Grep)" },
		},
	},

	-- 2. NAVIGASI CEPAT (Harpoon)
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()
			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end, { desc = "Add to Harpoon" })
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Open Harpoon Menu" })
		end,
	},

  -- TAMBAHAN: FILE EXPLORER (NvimTree)
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        renderer = { group_empty = true },
      })
    end,
    keys = {
      -- 🛠️ FIX: Kembalikan hak milik Spasi + e ke Explorer!
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Explorer" },
    },
  },

	-- 3. LOMPAT KILAT (Flash)
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash Jump",
			},
		},
	},

	-- 4. VISUAL GIT COMMAND CENTER (Lazygit)
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = { "LazyGit" }, -- Ini perbaikan yang bikin g bisa jalan di dashboard
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "Buka Lazygit" },
		},
	},

	-- 5. BUKU PANDUAN SHORTCUT (Which-Key)
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			spec = {
				{ "<leader>f", group = "🔭 Pencarian (Telescope/Flash)" },
				{ "<leader>g", group = "🐙 Git (Lazygit)" },
				{ "<leader>c", group = "🧠 Code Action (LSP)" },
				{ "<leader>r", group = "⚡ Rename & Run (Kulala)" },
			},
		},
	},
}
