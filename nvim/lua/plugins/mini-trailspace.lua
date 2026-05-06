return {
	"nvim-mini/mini.trailspace",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		only_in_normal_buffers = true,
	},
	config = function(_, opts)
		require("mini.trailspace").setup(opts)

		local function set_hl()
			vim.api.nvim_set_hl(0, "MiniTrailspace", { bg = "DarkRed" })
		end
		set_hl()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"text", "markdown", "gitcommit", "gitrebase",
				"help", "man", "qf",
			},
			callback = function()
				vim.b.minitrailspace_disable = true
			end,
		})
	end,
}
