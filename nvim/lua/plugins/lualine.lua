return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		sections = {
			lualine_c = {
				{
					'filename',
					path = 1,
				}
			},
		},
	},
	config = function(_, opts)
		require("lualine").setup(opts)
	end
}
