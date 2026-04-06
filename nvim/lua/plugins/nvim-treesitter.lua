return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()

		-- Install parsers
		local ensure_installed = {
			"asm",
			"bash",
			"c",
			"diff",
			"html",
			"javascript",
			"jsdoc",
			"json",
			"jsonc",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"printf",
			"python",
			"query",
			"regex",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
		}
		local installed = require("nvim-treesitter").get_installed()
		local to_install = vim.tbl_filter(function(lang)
			return not vim.list_contains(installed, lang)
		end, ensure_installed)
		if #to_install > 0 then
			require("nvim-treesitter").install(to_install)
		end

		-- Treesitter indent
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				if pcall(vim.treesitter.get_parser) then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
