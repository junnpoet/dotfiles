return {
	-- tools
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
                "css-lsp",
                "emmet-ls",
                "eslint-lsp",
                "json-lsp",
                "lua-language-server",
                "prettier",
				"selene",
				"shellcheck",
				"shfmt",
				"stylua",
                "vtsls",
			})
		end,
	},

    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            emmet_ls = {
                filetypes = { "html", "htm", "xhtml" },
            },
        },
    },
}
