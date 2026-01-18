return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- 1. 아이콘 모양 (깔끔한 막대 스타일)
		signs = {
			-- add          = { text = '┃' },
			-- change       = { text = '┃' },
			-- delete       = { text = '_' },
			-- topdelete    = { text = '‾' },
			-- changedelete = { text = '~' },

			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		signs_staged = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
		},
		-- 2. 기능 설정
		signcolumn = true,  -- 왼쪽 줄 번호 옆에 색깔 바 표시 (핵심!)
		numhl      = false, -- 줄 번호 자체 색깔 변경 (정신사나우면 끄기)
		linehl     = false, -- 줄 전체 배경색 변경 (너무 화려해서 비추천)
		word_diff  = false, -- 단어 단위 diff (필요하면 켜세요)
		-- 3. 현재 줄 Blame 표시 (누가 언제 짰는지 회색 글씨로)
		current_line_blame = false, -- 기본값은 끔
		current_line_blame_opts = {
			delay = 0,
			virt_text_pos = 'eol', -- 줄 끝에 표시
		},
	},

	config = function(_, opts)
		require('gitsigns').setup(opts)
		-- "원래 코드랑 뭐가 달라졌지?" 확인하는 단축키 (필수 추천)
		vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk_inline<CR>', { desc = 'Preview Git Hunk' })
		vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Toggle Git Blame' })
	end
}
