return {
	'saghen/blink.cmp',
	-- Track main (V2). Prebuilt binaries are published only for release tags,
	-- so the native fuzzy library is compiled from source here, which requires
	-- a Rust toolchain (cargo) on every machine. lazy runs this build hook
	-- automatically on install/update.
	build = function() require('blink.cmp').build():pwait() end,
	dependencies = {
		"saghen/blink.lib",
		"fang2hou/blink-copilot",
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
					name = "copilot",
					module = "blink-copilot",
					score_offset = 1000,
					async = true,
					opts = {
						max_completions = 3,
						max_attempts = 4,
						kind_icon = "",
					},
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

		-- Always use the Rust matcher; error instead of silently degrading to
		-- the Lua implementation if the compiled library is unavailable.
		fuzzy = { implementation = "rust" },
	},
}
