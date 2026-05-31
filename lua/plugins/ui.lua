-- ~/.config/nvim/lua/plugins/ui.lua

return {

	-- 1. TEMA TOKYONIGHT
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},

	-- 2. IKON
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- 3. STATUS BAR BAWAH (Lualine)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "tokyonight",
				},
			})
		end,
	},
-- 🪞 4. DASHBOARD PERSONAL (Alpha-nvim)
  {
      "goolord/alpha-nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
          local alpha = require("alpha")
          local dashboard = require("alpha.themes.dashboard")

          dashboard.section.header.val = {
              "                                                             ",
              "  ███╗   ███╗ █████╗ ██╗      █████╗ ███████╗██╗   ██╗██╗███╗   ███╗ ",
              "  ████╗ ████║██╔══██╗██║     ██╔══██╗██╔════╝██║   ██║██║████╗ ████║ ",
              "  ██╔████╔██║███████║██║     ███████║███████╗██║   ██║██║██╔████╔██║ ",
              "  ██║╚██╔╝██║██╔══██║██║     ██╔══██║╚════██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
              "  ██║ ╚═╝ ██║██║  ██║███████╗██║  ██║███████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
              "  ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
              "                                                                     ",
              "                        Welcome back, Notsuuu                        ",
              "                                                                     ",
          }

          dashboard.section.buttons.val = {
              dashboard.button("f", "󰈞  Cari File", ":Telescope find_files <CR>"),
              dashboard.button("e", "  File Baru", ":ene <BAR> startinsert <CR>"),
              dashboard.button("g", "󰊢  Git Status", ":LazyGit<CR>"),
              dashboard.button("q", "󰅙  Keluar", ":qa<CR>"),
          }
          local function footer()
              local stats = require("lazy").stats()
              local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
              return "⚡ MalasVim memuat " .. stats.loaded .. " / " .. stats.count .. " plugin dalam " .. ms .. " ms"
          end

          dashboard.section.footer.val = footer()
          dashboard.section.footer.opts.hl = "Comment" -- Memberikan warna abu-abu redup agar terlihat elegan

          -- Mengatur jarak antar bagian dashboard (agar tidak terlalu rapat ke bawah)
          dashboard.config.layout = {
              { type = "padding", val = 2 },
              dashboard.section.header,
              { type = "padding", val = 2 },
              dashboard.section.buttons,
              { type = "padding", val = 2 },
              dashboard.section.footer,
          }
          alpha.setup(dashboard.opts)
      end,
  },
}
