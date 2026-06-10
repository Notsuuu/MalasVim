return {
    "vyfor/cord.nvim",
    event = "VeryLazy",
    opts = {
        editor = {
            client = "1514377335535566998", 
            tooltip = "Distro Buatan Sendiri 🚀", 
            icon = "https://raw.githubusercontent.com/neovim/neovim.github.io/master/logos/neovim-mark.svg",
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
            workspace = function(opts) 
                return "Di proyek " .. (opts.workspace or "Lokal") .. " 🚀" 
            end,
            viewing = function(opts) 
                return "Melihat " .. (opts.filename or "file") .. " 🧐" 
            end,
            editing = function(opts) 
                return "Mengedit " .. (opts.filename or "file") .. " 💻" 
            end,
        },
    },
}
