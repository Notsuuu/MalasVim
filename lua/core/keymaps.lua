-- ~/.config/nvim/lua/core/keymaps.lua
local map = vim.keymap.set

-- Mode Normal: Keluar dan Save cepat ala pemalas
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Mode Normal: Menghapus 1 huruf tanpa menimpanya ke clipboard (Void Register)
-- Ini sangat berguna kalau kamu mau nge-paste sesuatu, tapi harus menghapus 1 huruf yang salah dulu
map("n", "x", '"_x')

-- Mode Visual: Menggeser blok teks ke kiri/kanan dengan tombol < dan >
-- Tambahan 'gv' bikin blok teksnya tetap tersorot setelah digeser, jadi bisa digeser berkali-kali!
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Menghilangkan highlight kuning setelah selesai mencari kata pakai '/' (biar mata tidak sakit)
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear Search Highlight" })

-- Lompat antar jendela secepat kilat (Explorer <-> File)
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window (NvimTree)" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window (File)" })
