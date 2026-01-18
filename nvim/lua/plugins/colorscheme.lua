return {
--	"wtfox/jellybeans.nvim",
--	"catppuccin/nvim",
	"rebelot/kanagawa.nvim",
--	"darianmorat/gruvdark.nvim",
--	"vague-theme/vague.nvim",
--	"EdenEast/nightfox.nvim",
--	"Mofiqul/vscode.nvim",
--	"folke/tokyonight.nvim",

	priority = 1000,
	lazy = false,

	config = function()
		-- local theme = "jellybeans"
		-- local theme = "catppuccin-mocha"
		local theme = "kanagawa-wave"
		-- local theme = "gruvdark"
		-- local theme = "vague"
		-- local theme = "nightfox"
		-- local theme = "vscode"
		-- local theme = "tokyonight-night"
		vim.cmd("colorscheme " .. theme)

--		if theme == "jellybeans" then
			local colors = {
				border = "#54546d", -- 테두리 색상
				prompt = "#8adbb4", -- 프롬프트 테두리 녹색
				separator = "#54546d"
			}
			local hl_groups = {
				TelescopeBorder = { fg = colors.border },
				TelescopePromptBorder = { fg = colors.prompt },
				TelescopeResultsBorder = { fg = colors.border },
				TelescopePreviewBorder = { fg = colors.border },
				TelescopePromptTitle = { fg = colors.prompt, bold = true },
				TelescopeResultsTitle = { fg = colors.border, bold = true },
				TelescopePreviewTitle = { fg = colors.border, bold = true },

				WinSeparator = { fg = colors.separator },
				VertSplit = { fg = colors.separator },
			}
			for group, settings in pairs(hl_groups) do
				vim.api.nvim_set_hl(0, group, settings)
			end
--		end

		--vim.api.nvim_set_hl(0, "ColorColumn", { bg = "DarkGrey" })
		vim.api.nvim_set_hl(0, "ColorColumn", { bg = "Gray40" })
		-- trailing whitespace highlight 그룹
		vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "DarkRed" })
		-- whitespace 경고를 특정 파일 타입에서만 적용
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "c", "cpp", "h", "hpp", "py", "sh", "yml", "lua", },
			callback = function()
				-- 이전 match 제거 (다른 파일로 이동 후 잔여 match 남는 문제 방지)
				vim.cmd([[match none]])
				-- 현재 버퍼에만 whitespace match 적용
				vim.cmd([[match ExtraWhitespace /\s\+$/]])
			end,
		})
		-- FileType 변경 시 자동으로 match 유지 안될 수 있어서,
		-- InsertLeave 때도 다시 적용
		vim.api.nvim_create_autocmd("InsertLeave", {
			pattern = { "*.c", "*.cpp", "*.h", "*.hpp", "*.py", "*.sh", "*.yml", "*.lua", },
			callback = function()
				vim.cmd([[match ExtraWhitespace /\s\+$/]])
			end,
		})
	end,
}
