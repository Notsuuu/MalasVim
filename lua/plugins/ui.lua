return {
	-- 1. TEMA TOKYONIGHT
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
        require("tokyonight").setup({
          transparent = true,
          styles = {
            sidebars = "transparent",
            floats = "transparent",
          },
        })

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
            vim.opt.laststatus = 3

            -- Menghancurkan dinding hitam bawaan Neovim
            vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })

            local function save_status()
                if vim.bo.buftype ~= "" then return "" end 
                if vim.bo.readonly then return "🔒 Readonly" end
                if vim.bo.modified then return "⚠️ Belum di-save" end
                return "💾 Sudah di-save"
            end

            local custom_theme = require("lualine.themes.tokyonight")
            for _, mode in pairs(custom_theme) do 
                if mode.c then mode.c.bg = "NONE" end
                if mode.x then mode.x.bg = "NONE" end
            end

            require("lualine").setup({
                options = {
                    theme = custom_theme, 
                    globalstatus = true,
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 
                        'filename',
                        save_status,
                        { function() return " " end, padding = { left = 1, right = 0 } }
                    },
                    lualine_x = { 
                        { function() return " " end, padding = { left = 0, right = 1 } },
                        function() return "󰣇 Arch" end,
                        'filetype',
                        'location'
                    },
                    lualine_y = { 
                        function() return os.date('%d/%m/%y') end 
                    },
                    lualine_z = { 
                        function() return os.date('%H:%M') end 
                    }
                },
            })
        end
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
              "                        Welcome Back, Notsuuu                        ",
              "                                                                     ",
          }

          dashboard.section.buttons.val = {
              dashboard.button("f", "󰈞  Cari File", ":Telescope find_files <CR>"),
              dashboard.button("e", "  File Baru", ":ene <BAR> startinsert <CR>"),
              dashboard.button("g", "󰊢  Git Status", ":LazyGit<CR>"),
              dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
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
