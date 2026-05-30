-- ==========================================
-- 1. PENGATURAN DASAR (OPTIONS)
-- ==========================================
vim.g.mapleader = " " -- Tombol Spasi sebagai 'Leader Key'
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.opt.number = true -- Menampilkan nomor baris
vim.opt.relativenumber = true -- Nomor baris relatif
vim.opt.tabstop = 4 -- Ukuran tab
vim.opt.shiftwidth = 4 -- Ukuran indentasi
vim.opt.expandtab = true -- Ubah tab menjadi spasi
vim.opt.termguicolors = true -- Warna yang lebih bagus

-- ==========================================
-- 2. BOOTSTRAP LAZY.NVIM
-- ==========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- ==========================================
-- 3. SETUP PLUGIN
-- ==========================================
require("lazy").setup({

	-- 📁 1. FILE EXPLORER: Nvim-Tree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup()
			vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
		end,
	},

	-- 🎨 2. SYNTAX HIGHLIGHTING: Treesitter (SAFE MODE)
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
					"c",
					"lua",
					"vim",
					"vimdoc",
					"javascript",
					"typescript",
					"python",
					"php",
					"html",
					"css",
				},
				highlight = { enable = true },
			})
		end,
	},

	-- 🐙 3. GIT COMMAND CENTER: LazyGit

	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "Buka Lazygit" },
		},
	},

	-- 🤖 4. AI ASSISTANT: GitHub Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = { accept = "<Tab>" },
				},
			})
		end,
	},

	-- 🌙 5. TEMA: Tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},

	-- 🧠 6. LANGUAGE SERVER PROTOCOL (LSP) - VERSI NEOVIM 0.11+
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "intelephense", "pyright" },
			})

			-- Konfigurasi Native Neovim 0.11+
			vim.lsp.config("lua_ls", {
				settings = { Lua = { diagnostics = { globals = { "vim" } } } },
			})
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("intelephense")
			vim.lsp.enable("pyright")

			-- Shortcut LSP
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Lihat Dokumentasi/Info" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Variable" })
		end,
	},

	-- ⚡ 7. AUTOCOMPLETE (nvim-cmp)
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			luasnip.setup({
				enable_autosnippets = true,
				history = true,
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- 🔭 8. FUZZY FINDER (Telescope)
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Cari File" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Cari Kata" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Cari Tab Aktif" })
		end,
	},

	-- 🚥 9. STATUS LINE (Lualine)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "tokyonight",
					component_separators = "|",
					section_separators = { left = "", right = "" },
				},
			})
		end,
	},

	-- ✨ 10. AUTO-FORMATTER (Conform.nvim)
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					python = { "black" },
					php = { "pint" },
				},
				format_on_save = {
					timeout_ms = 1000,
					lsp_fallback = true,
				},
			})
		end,
	},

	-- 🧩 11. AUTO PAIRS (Tutup Kurung Otomatis)
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	-- 🎨 12. COLORIZER (Pewarna Kode Warna/Tailwind)
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					tailwind = true,
				},
			})
		end,
	},

	-- 💻 13. TOGGLETERM (Terminal Melayang)
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				direction = "float",
				open_mapping = [[<c-\>]], -- Tekan Ctrl + \ untuk buka/tutup terminal
			})
		end,
	},

	-- 🏷️ 14. TS-AUTOTAG (Penutup Tag HTML/JSX Otomatis)
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- 🎮 15. DISCORD RICH PRESENCE (Status Profil Discord)
	{
		"andweeb/presence.nvim",
		config = function()
			require("presence").setup({
				main_image = "neovim",
				neovim_image_text = "Ngeracik kode di MalasVim",
				show_time = true,
			})
		end,
	},

	-- 🪞 16. DASHBOARD PERSONAL (Alpha-nvim)
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				"                                                                     ",
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

	-- ⚡ 17. HARPOON (Navigasi Antar-File Super Cepat)
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			-- Tombol pintasan Harpoon
			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end, { desc = "Tambahkan File ke Harpoon" })
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Buka Menu Harpoon" })

			-- Lompat instan ke file yang sudah ditandai (Ctrl + 1, 2, 3, 4)
			vim.keymap.set("n", "<C-1>", function()
				harpoon:list():select(1)
			end, { desc = "Lompat ke File 1" })
			vim.keymap.set("n", "<C-2>", function()
				harpoon:list():select(2)
			end, { desc = "Lompat ke File 2" })
			vim.keymap.set("n", "<C-3>", function()
				harpoon:list():select(3)
			end, { desc = "Lompat ke File 3" })
			vim.keymap.set("n", "<C-4>", function()
				harpoon:list():select(4)
			end, { desc = "Lompat ke File 4" })
		end,
	},

	-- 📡 18. KULALA (REST API Client / Postman di Terminal)
	{
		"mistweaverco/kulala.nvim",
		opts = {},
		config = function()
			-- Cukup buat file berakhiran .http, lalu tekan Spasi + R untuk eksekusi API
			vim.keymap.set("n", "<leader>R", function()
				require("kulala").run()
			end, { desc = "Jalankan HTTP Request" })
			vim.keymap.set("n", "<leader>T", function()
				require("kulala").toggle_view()
			end, { desc = "Lihat Headers/Body" })
		end,
	},

	-- 🚀 19. FLASH.NVIM (Teleportasi Kursor Tanpa Mouse)
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
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
	},
}, {
	rocks = { enabled = false },
})
