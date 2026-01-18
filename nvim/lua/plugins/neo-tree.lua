return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		opts = {
			sources = { "filesystem", "buffers", "git_status" }, 
			filesystem = {
				filtered_items = {
					-- hide_dotfiles = false,
					-- hide_gitignored = false,
					-- hide_hidden = false,
				},
			},
		},
		config = function(_, opts)
			vim.keymap.set("n", "<leader>ce", "<cmd>Neotree reveal toggle<cr>", { desc = "File Explorer (Neotree)" })
			require("neo-tree").setup(opts)
		end,
	}
}
