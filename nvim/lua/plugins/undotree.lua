return {
	"jiaoshijie/undotree",
	dependencies = "nvim-lua/plenary.nvim",
	config = true,
	keys = {
		{ "<leader>cu", "<cmd>lua require('undotree').toggle()<cr>", desc = "Code UndoTree" },
	},
}
