return {
	"zbirenbaum/copilot.lua",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = false,
--				auto_trigger = true,
--				keymap = {
--					accept = "<C-l>",
--					dismiss = "<C-]>",
--				},
			},
			panel = { enabled = false },
		})
	end,
}
