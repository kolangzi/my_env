return {
	-- markdown-preview: based on browser
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install && git checkout -- .",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview (Browser)" },
		},
	},
	-- markview: based on buffer
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		config = function()
			require("markview").setup({
				preview = {
					enable = false,
				},
				markdown = {
					tables = {
						parts = {
							top = { "╭", "─", "╮", "┬" },
							header = { "│", "│", "│" },
							separator = { "├", "─", "┤", "┼" },
							row = { "│", "│", "│" },
							bottom = { "╰", "─", "╯", "┴" },
							align = { "╼", "╾", "╴╶" },
						},
					},
				},
			})
		end,
		keys = {
			{ "<leader>mr", "<cmd>Markview Toggle<cr>", desc = "Render Markdown (Buffer)" },
		},
	},
}
