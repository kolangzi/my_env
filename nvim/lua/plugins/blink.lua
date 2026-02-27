return {
	'saghen/blink.cmp',
	build = 'cargo build --release',
	dependencies = {
		"giuxtaposition/blink-cmp-copilot",
		"zbirenbaum/copilot.lua",
	},
	opts = {
		keymap = {
			preset = "none",
			['<CR>'] = { 'accept', 'fallback' },
			['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
			['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
			['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
			['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer", "copilot" },
			providers = {
				copilot = {
					name = "Copilot",
					module = "blink-cmp-copilot",
					score_offset = 1000, -- set high to prioritize Copilot suggestions
					async = true,
					transform_items = function(_, items)
						for _, item in ipairs(items) do
							item.kind_icon = ""
							item.kind_name = "Copilot"
						end
						return items
					end,
				},
			},
		},

		completion = {
			list = {
				max_items = 10,
				selection = {
					preselect = false,
					auto_insert = false,
				}
			},
			menu = {
				border = "rounded",
				-- direction_priority = { "n", "s" },
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 300,
				window = { border = "rounded", },
			},
			ghost_text = { enabled = false, },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		signature = { enabled = true },
	},
}
