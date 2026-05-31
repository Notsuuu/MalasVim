-- ~/.config/nvim/lua/core/options.lua
local opt = vim.opt

-- Spasi sebagai tombol Leader (Wajib paling atas)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Mematikan provider yang tidak dipakai agar Neovim lebih ngebut
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

-- Tampilan Editor
opt.number = true -- Menampilkan nomor baris
opt.relativenumber = true -- Nomor baris relatif (gampang untuk lompat)
opt.cursorline = true -- Highlight baris kursor
opt.wrap = false -- Teks tidak turun ke bawah walau panjang

-- Indentasi (Standar Web Dev & IoT)
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Performa & Sistem
opt.clipboard = "unnamedplus" -- Sinkronisasi clipboard Neovim dengan OS
opt.ignorecase = true -- Pencarian tidak case-sensitive...
opt.smartcase = true -- ...kecuali pakai huruf kapital
opt.termguicolors = true -- Warna terminal true-color
opt.updatetime = 250 -- Waktu update UI lebih cepat
opt.signcolumn = "yes" -- Kolom kiri untuk ikon error/git
