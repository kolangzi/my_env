return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {},
	config = function()
		-- 인덴트 라인을 Kanagawa 배경과 잘 어울리게 아주 흐리게 설정
		vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2a2a2a" }) -- 현재 유지

		require("ibl").setup({
			indent = {
				char = "│",
				tab_char = "│",
			},
			-- [수정] 스코프 강조는 mini.indentscope에 맡기기 위해 비활성화합니다.
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
