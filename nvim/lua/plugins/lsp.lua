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
				ensure_installed = { "clangd", "pyright", "ruff" },
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
			-- pyright: type checking, completions, go-to-definition
			------------------------------------------------------------------
			vim.lsp.config("pyright", {
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_markers = {
					"pyproject.toml",
					"setup.py",
					"setup.cfg",
					"requirements.txt",
					".git",
				},
				settings = {
					pyright = {
						-- let ruff handle import sorting
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			})
			vim.lsp.enable("pyright")

			------------------------------------------------------------------
			-- ruff: linting, formatting, import sorting
			------------------------------------------------------------------
			vim.lsp.config("ruff", {
				cmd = { "ruff", "server" },
				filetypes = { "python" },
				root_markers = {
					"pyproject.toml",
					"ruff.toml",
					".ruff.toml",
					".git",
				},
				on_attach = function(client)
					-- defer hover to pyright
					client.server_capabilities.hoverProvider = false
				end,
			})
			vim.lsp.enable("ruff")

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
