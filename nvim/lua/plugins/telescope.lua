return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set( "n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find files" })
			vim.keymap.set( "n", "<leader>fg", builtin.live_grep, { desc = "Telescope: Live grep" })
			vim.keymap.set( "n", "<leader>fb", builtin.buffers, { desc = "Telescope: Buffers" })
			vim.keymap.set( "n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Help tags" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = 'vertical',
					layout_config = {
						vertical = { prompt_position = 'top', },
					},
					sorting_strategy = 'ascending',
					winblend = 10,
					borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
					color_devicons = true,
					file_ignore_patterns = { "%.git" },
				},
				pickers = {
					find_files = {
						find_command = {
							'fd', '--type', 'f', '-H', '--strip-cwd-prefix',
						},
						--						theme = "dropdown",
						preview_title = "File Preview",
					},
					live_grep = {
						preview_title = "Grep Preview",
						additional_args = function()
							return { "--case-sensitive" }
						end,
					},
				},
			})
		end,
	},
}
