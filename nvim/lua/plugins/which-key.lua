return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>c", group = "Code" },
			{ "<leader>g", group = "Git" },
			{ "<leader>f", group = "File" },
			{ "<leader>o", group = "Overseer" },
			{ "<leader>o", group = "Overseer", icon = " " },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
