return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
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
		signcolumn = true,  -- 왼쪽 줄 번호 옆에 색깔 바 표시
		numhl      = false, -- 줄 번호 자체 색깔 변경
		linehl     = false, -- 줄 전체 배경색 변경
		word_diff  = false, -- 단어 단위 diff
		-- 3. 현재 줄 Blame 표시
		current_line_blame = false,
		current_line_blame_opts = {
			delay = 0,
			virt_text_pos = 'eol',
		},
	},

	config = function(_, opts)
		require('gitsigns').setup(opts)
		vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk_inline<CR>', { desc = 'Preview Git Hunk' })
		vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Toggle Git Blame' })
	end
}
