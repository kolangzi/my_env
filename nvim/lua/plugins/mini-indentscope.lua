return {
	"echasnovski/mini.indentscope",
	version = false, -- latest commit
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- 강조할 문자 설정
		symbol = "│",
		options = {
			try_as_border = true, -- 블록의 시작과 끝을 더 잘 인식함
		},
		draw = {
			delay = 50, -- 강조 표시 지연 시간 (밀리초)
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"help", "alpha", "dashboard", "neo-tree",
				"Trouble", "lazy", "mason", "notify",
				"toggleterm", "lazyterm",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
}
