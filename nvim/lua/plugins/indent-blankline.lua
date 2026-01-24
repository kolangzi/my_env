return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {},
	config = function()
		vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2a2a2a" })

		require("ibl").setup({
			indent = {
				char = "│",
				tab_char = "│",
			},
			-- 스코프 강조는 mini.indentscope에 맡기기 위해 비활성화
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help", "alpha", "dashboard", "neo-tree",
					"Trouble", "lazy", "mason", "notify",
					"toggleterm", "lazyterm",
				},
			}
		})
	end,
}
