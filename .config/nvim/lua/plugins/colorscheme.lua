return {
    -- {
    --   "folke/tokyonight.nvim",
    --   lazy = true,
    --   priority = 1000,
    --   opts = function()
    --     return {
    --       transparent = true,
    --     }
    --   end,
    -- },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        priority = 1000,
        opts = {
            options = {
                transparent = true,
                styles = {
                    comments = "italic",
                    keywords = "bold",
                    types = "italic,bold",
                },
            },
        },
    },
}
