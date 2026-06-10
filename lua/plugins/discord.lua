return {
    "vyfor/cord.nvim",
    event = "VeryLazy",
    opts = {
        editor = {
            client = "1514377335535566998", 
            tooltip = "Distro Buatan Sendiri 🚀", 
            icon = "neovim_logo",
        },
        display = {
            theme = "catppuccin", 
            flavor = "dark",      
            swap_fields = false,
        },
        idle = {
            enabled = true,
            timeout = 300000, 
            show_status = true,
            details = "Lagi AFK di MalasVIM... 💤", 
        },
        text = {
            dashboard = "Welcome Back, Notsuuu 👋",
            workspace = function(opts) 
                return "Di Direktori " .. (opts.workspace or "Lokal") .. " 🚀" 
            end,
            viewing = function(opts) 
                return "Melihat " .. (opts.filename or "file") .. " 🧐" 
            end,
            editing = function(opts) 
                return "Sedang Ngoding di File " .. (opts.filename or "file") .. " 💻" 
            end,
            file_browser = function(opts) 
                return "Mencari File di " .. (opts.name or "Explorer") .. " 📁" 
            end,
            plugin = function(opts) 
                return "Ngoprek Plugin " .. (opts.name or "Plugin") .. " ⚙️" 
            end,
            vcs = function(opts)
                return "Mengamankan Kode di " .. (opts.name or "Git") .. " 🌿"
            end,
            terminal = function(opts)
                return "Ngetik Command di " .. (opts.name or "Terminal") .. " 📟"
            end,
        },
    },
}
