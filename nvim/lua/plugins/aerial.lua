return {
	"stevearc/aerial.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		update_delay = 500,
		link_tree_to_folds = false,
		link_folds_to_tree = false,

		filter_kind = {
			"Class", "Constructor", "Enum", "Function", "Interface",
			"Module", "Method", "Struct", "Variable", "Constant", "Macro",
		},

		backends = { "treesitter", "lsp", "markdown", "man" },

		show_guides = true,

		nav = {
			preview = true,
			max_width = 0.5,
			win_opts = {
				cursorline = true,
				winblend = 10,
			},
		},

		layout = {
			resize_to_content = false,
--			min_width = 25,
--			max_width = 40,
			default_direction = "right",
			win_opts = {
				winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
				signcolumn = "yes",
				statuscolumn = " ",
			},
			guides = {
				mid_item   = "├╴",
				last_item  = "└╴",
				nested_top = "│ ",
				whitespace = "  ",
			},
		},

		highlight_on_hover = true,
		on_attach = function(bufnr)
			vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Prev Symbol" })
			vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Next Symbol" })
		end,
	},
	keys = {
		{ "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Symbols Tree (Aerial)" },
	},
}
