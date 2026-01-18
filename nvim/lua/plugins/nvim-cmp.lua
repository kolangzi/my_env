return {
	{
		"hrsh7th/nvim-cmp",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"rafamadriz/friendly-snippets",
			"zbirenbaum/copilot-cmp",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Copilot highlight
			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
						else
							fallback()
						end
					end, { "i", "s" }),

					-- [Enter]: 수동으로 항목을 선택(Tab 등)했을 때만 확정합니다.
					-- 아무것도 선택하지 않고 엔터를 치면 그냥 줄바꿈이 됩니다.
					["<CR>"] = cmp.mapping.confirm({
						select = false,
					}),

					['<Esc>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.abort() -- 메뉴를 닫고 입력을 취소합니다.
							-- 그 다음 바로 Normal 모드로 나가기 위해 <Esc>를 다시 보냅니다.
							vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
						else
							fallback()
						end
					end),
				}),

				sources = cmp.config.sources({
					{ name = "copilot", max_item_count = 3 },
					{ name = "nvim_lsp", max_item_count = 10 },
					{ name = "buffer",  max_item_count = 5 },
					{ name = "path",    max_item_count = 3 },
					{ name = "luasnip", max_item_count = 3 },
				}),

				formatting = {
					format = function(entry, vim_item)
						if entry.source.name == "copilot" then
							vim_item.kind = " Copilot"
							vim_item.kind_hl_group = "CmpItemKindCopilot"

							-- 🔥 remove preview-style "ghost" text
							-- Using only label = the actual text shown inside menu
							vim_item.abbr = vim_item.abbr or ""
						end
						return vim_item
					end,
				},
			})
		end,
	},
}
