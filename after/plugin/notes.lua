require("neorg").setup {
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.export"] = {
            config = {
                extensions = "all",
            },
        },
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp", -- We current support nvim-compe and nvim-cmp only
            },
        },
        ["core.keybinds"] = {
            config = {
                default_keybinds = true,
                neorg_leader = "<Leader>o",
            },
        },
        ["core.journal"] = {
            config = { -- Note that this table is optional and doesn't need to be provided
                -- Configuration here
                workspace = "my_ws",
                jornal_folder = "./gtd/journal",
                strategy = "flat",
            },
        },
        ["core.concealer"] = {
            config = {
                icon_preset = "diamond",
                -- width = "content",
            },
        },
        ["core.dirman"] = {
            config = {
                workspaces = {
                    my_ws = "/home/illumiko/Documents/norg/",
                },
                index = "index.norg",
                default_workspace = "my_ws",
                open_last_workspace = false,
            },
        }
    }
}
