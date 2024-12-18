return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            emmet_ls = {
                filetypes = { "html", "htm", "xhtml" },
            },
        },
    },
}
