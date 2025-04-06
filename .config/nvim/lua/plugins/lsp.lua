return {
	-- tools
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
                "css-lsp",
                "emmet-ls",
                "eslint-lsp",
                "html-lsp",
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
            cssls = {
                settings = {
                    css = {
                        completion = {
                            triggerPropertyValueCompletion = false, -- Desactiva autocompletado inmediato dentro de valores
                            completePropertyWithSemicolon = false, -- Evita autocompletar con `;`
                        },
                    },
                    scss = {
                        completion = {
                            triggerPropertyValueCompletion = false,
                            completePropertyWithSemicolon = false,
                        },
                    },
                    less = {
                        completion = {
                            triggerPropertyValueCompletion = false,
                            completePropertyWithSemicolon = false,
                        },
                    },
                },
            },
            emmet_ls = {
                filetypes = { "html", "htm", "xhtml" },
            },
        },
    },
}
