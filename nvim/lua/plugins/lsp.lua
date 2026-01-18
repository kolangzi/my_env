return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd" },
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			------------------------------------------------------------------
			-- clangd server configuration (Neovim 0.11+ native style)
			------------------------------------------------------------------
			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--header-insertion=never",
					"--background-index",
				},
				filetypes = { "c", "cpp", "objc", "objcpp" },

				-- root directory detection
				root_markers = {
					".clangd",
					"compile_commands.json",
					"compile_flags.txt",
					".git",
				},

				-- REQUIRED for clangd + treesitter compatibility
				capabilities = {
					offsetEncoding = { "utf-16" },
				},
			})

			-- explicitly enable clangd
			vim.lsp.enable("clangd")

			------------------------------------------------------------------
			-- Keymaps (unchanged behavior)
			------------------------------------------------------------------
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local buf = event.buf

					vim.keymap.set( "n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "Show Hover Info" })
					vim.keymap.set( "n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to Definition" })
					vim.keymap.set( "n", "gD", vim.lsp.buf.declaration, { buffer = buf, desc = "Go to Declaration" })
					vim.keymap.set( "n", "gI", vim.lsp.buf.implementation, { buffer = buf, desc = "Go to Implementation" })
					vim.keymap.set( "n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code Action (LSP)" })
					vim.keymap.set( "n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show Diagnostic (LSP)" })
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { desc = "Go to References (LSP)" })
				end,
			})
		end,
	},
}
