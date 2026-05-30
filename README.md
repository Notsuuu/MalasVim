# 🦥 MalasVim v1.0

A blazing-fast, lightweight, and modern Neovim IDE configuration tailored for Full-Stack Web Developers, Python enthusiasts, and IoT hackers. Built entirely on top of **Lazy.nvim** and written 100% in Lua.

```text
  ███╗   ███╗ █████╗ ██╗      █████╗ ███████╗██╗   ██╗██╗███╗   ███╗
  ████╗ ████║██╔══██╗██║     ██╔══██╗██╔════╝██║   ██║██║████╗ ████║
  ██╔████╔██║███████║██║     ███████║███████╗██║   ██║██║██╔████╔██║
  ██║╚██╔╝██║██╔══██║██║     ██╔══██║╚════██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚═╝ ██║██║  ██║███████╗██║  ██║███████║ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
```

---

## 🚀 Fitur Unggulan

* **🧠 Modern LSP Config & Autocomplete:** Menggunakan native Neovim 0.11+ LSP engine dipadukan dengan Mason untuk manajemen server otomatis.
* **🤖 AI Integration:** Dukungan penuh untuk **GitHub Copilot** langsung di dalam *insert mode*.
* **✨ Auto-Formatter on Save:** Kode otomatis rapi seketika saat di-save menggunakan **Conform.nvim** (Mendukung Prettier, Black, Stylua, dan Laravel Pint).
* **🔭 Ultra-Fast Fuzzy Finder:** Navigasi proyek raksasa tanpa hambatan berkat **Telescope.nvim**, `ripgrep`, dan `fd-find`.
* **💻 Terminal Melayang (ToggleTerm):** Akses terminal Linux instan lewat jendela pop-up melayang di dalam editor.
* **📡 REST Client Terintegrasi (Kulala):** Eksekusi HTTP Request dan uji API langsung dari editor tanpa perlu membuka Postman.
* **⚡ Teleportasi Kursor (Flash.nvim) & Harpoon:** Lompat ke kata apa pun di layar dan kelola file aktif secepat kilat.
* **🎨 Estetika Tingkat Tinggi:** Tampilan gelap nan nyaman dari **Tokyonight Moon**, bar status informasi dari **Lualine**, serta pewarna kode warna (Tailwind CSS) otomatis dari **Colorizer**.

---

## 📦 Prasyarat Sistem (Prerequisites)

Konfigurasi ini dioptimalkan untuk **Arch Linux**. Sebelum memasang, pastikan sistemmu sudah memiliki peralatan tempur berikut:

### 1. Dependensi Inti Sistem
```bash
sudo pacman -S base-devel tree-sitter tree-sitter-cli ripgrep fd unzip curl git
```

### 2. Runtime Bahasa & Package Manager
```bash
# Node.js & NPM (Untuk web development & server pendukung)
sudo pacman -S nodejs npm

# PHP & Composer (Khusus untuk ekosistem Laravel)
sudo pacman -S php composer
```

---

## 🛠️ Langkah Instalasi (Installation)

Ikuti jalur ninja berikut untuk menyulap Neovim standarmu menjadi **MalasVim**:

### 1. Amankan Konfigurasi Lama (Backup)
Jika kamu sudah punya config Neovim sebelumnya, bersihkan atau amankan dulu agar tidak terjadi konflik:
```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### 2. Pasang Struktur Folder MalasVim
Buat folder konfigurasi baru dan klon/buat file `init.lua` di dalamnya:
```bash
mkdir -p ~/.config/nvim
```
Salin seluruh kode `init.lua` dari repositori ini dan letakkan ke dalam file `~/.config/nvim/init.lua`.

### 3. Inisialisasi Pertama Kali
Buka Neovim melalui terminal:
```bash
nvim
```
*Saat pertama kali dibuka, **Lazy.nvim** akan otomatis mendownload semua plugin yang dibutuhkan. Biarkan prosesnya berjalan hingga selesai, lalu keluar (`:qa`).*

### 4. Pasang Formatter & LSP Global via Mason
Buka kembali Neovim, lalu jalankan perintah ini untuk memasang perapi kode otomatis:
```vim
:MasonInstall prettier black stylua pint
```

### 5. Otorisasi GitHub Copilot (Jika menggunakan)
Aktifkan kecerdasan buatan Copilot dengan menghubungkannya ke akun GitHub-mu:
```vim
:Copilot auth
```
*Ikuti petunjuk di layar, masukkan 8 digit kode ke browser, dan tekan Enter di terminal Neovim.*

---

## 🕹️ Daftar Jalan Pintas Rahasia (Keymaps Cheat Sheet)

Gunakan *memori otot* jarimu untuk menguasai shortcut esensial ini (Tombol `<leader>` adalah **Spasi**):

### 📁 Navigasi & Eksplorasi File
* `Spasi` + `e` : Buka / Tutup File Explorer Sidebar (`Nvim-Tree`).
* `Spasi` + `ff` : Cari file apa saja di dalam folder proyek (`Telescope`).
* `Spasi` + `fg` : Cari kata spesifik di seluruh baris kode file (`Live Grep`).
* `Ctrl` + `e` : Buka menu cepat file favorit (`Harpoon`).
* `Spasi` + `a` : Daftarkan file aktif saat ini ke dalam (`Harpoon`).
* `Ctrl` + `1` / `2` / `3` / `4` : Lompat instan ke file Harpoon urutan 1-4.

### ⚡ Produktivitas & Editing
* `s` (Mode Normal) : Aktifkan mode Flash, ketik 2 huruf kata tujuan, lalu ketik label alfabet untuk teleportasi kursor.
* `Ctrl` + `\` : Munculkan / Sembunyikan terminal melayang (`ToggleTerm`).
* `Tab` (Insert Mode) : Menerima saran kode gaib dari GitHub Copilot.
* `:w` (Save File) : Otomatis merapikan spasi, indentasi, dan titik koma (`Conform`).

### 🧠 Navigasi Kode Server (LSP)
* `K` (Shift + k) : Memunculkan dokumentasi/tipe data fungsi di bawah kursor.
* `g` + `d` : Lompat ke file/baris tempat fungsi/variabel pertama kali dideklarasikan.
* `Spasi` + `ca` : Eksekusi *Code Action* (Saran perbaikan error otomatis dari LSP).
* `Spasi` + `rn` : Mengubah nama variabel secara massal di seluruh file (*Smart Rename*).

### 🐙 Manajemen Git & API Testing
* `Spasi` + `gs` : Buka Git Control Center (`Neogit`) untuk commit/push visual.
* `Spasi` + `R` : Jalankan eksekusi HTTP Request pada file `.http` aktif (`Kulala`).
* `Spasi` + `T` : Berganti tampilan antara Headers dan Body pada hasil response API (`Kulala`).

---

## 📜 Lisensi
Dikembangkan secara lokal dengan penuh rasa malas oleh **Muhammad Ali Mubaraq (Notsuuu)**. Bebas digunakan, dimodifikasi, dan disebarluaskan oleh sesama kaum pencinta terminal cepat. 

*Gas terus kawan!* 🚀🔥
