return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	config = function()
		local header = {
			"",
			" ██╗    ██╗ █████╗ ███╗   ██╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
			" ██║    ██║██╔══██╗████╗  ██║██╔════╝ ██║   ██║██║████╗ ████║",
			" ██║ █╗ ██║███████║██╔██╗ ██║██║  ███╗██║   ██║██║██╔████╔██║",
			" ██║███╗██║██╔══██║██║╚██╗██║██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
			" ╚███╔███╔╝██║  ██║██║ ╚████║╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
			"  ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
			"",
			" " .. os.date("%A, %Y-%m-%d"),
			"",
		}

		require('dashboard').setup {
			theme = 'hyper',
			shortcut_type = 'letter',
			config = {
				header = header,
				shortcut = {
--					{
--						icon = ' ',
--						icon_hl = 'String',
--						desc = 'New File',
--						group = 'String',
--						action = 'ene',
--						key = 'n',
--					},
					{
						icon = '󰈞 ',
						icon_hl = 'Function',
						desc = 'Find Files',
						group = 'Function',
						action = 'Telescope find_files',
						key = 'f',
					},
					{
						icon = '󰺮 ',
						icon_hl = 'Number',
						desc = 'Grep',
						group = 'Number',
						action = 'Telescope live_grep',
						key = 'g'
					},
					{
						icon = ' ',
						icon_hl = '@property',
						desc = 'Settings',
						group = '@property',
						key = 's',
						action = function()
							local config_dir = vim.fn.stdpath("config")

							vim.api.nvim_set_current_dir(config_dir)
							require('telescope.builtin').find_files({
								cwd = config_dir,
								prompt_title = "< Neovim Config >",
							})
						end,
					},
					{
						icon = '󰚰 ',
						icon_hl = 'Special',
						desc = 'Lazy Sync',
						group = 'Special',
						action = 'Lazy sync',
						key = 'u'
					},
				},
			},
		}
		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#7AA89F" })
	end,
	dependencies = {
		{'nvim-tree/nvim-web-devicons'}
	}
}
