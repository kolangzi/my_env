-- Tab navigation
vim.keymap.set("n", "<F2>", "gT", { noremap = true, silent = true, desc = "Previous tab", })
vim.keymap.set("n", "<F3>", "gt", { noremap = true, silent = true, desc = "Next tab", })
vim.keymap.set("n", "<F9>", ":tabnew<CR>", { noremap = true, silent = true, desc = "Open new tab", })

-- Indentation settings (4 spaces)
vim.keymap.set("n", "<F7>", function()
	vim.opt.tabstop = 4
	vim.opt.shiftwidth = 4
	-- vim.opt.expandtab = true
end, {
		noremap = true,
		silent = true,
		desc = "Set indent to 4 spaces",
	})
-- Indentation settings (8 spaces)
vim.keymap.set("n", "<F8>", function()
	vim.opt.tabstop = 8
	vim.opt.shiftwidth = 8
	-- vim.opt.expandtab = true
end, {
		noremap = true,
		silent = true,
		desc = "Set indent to 8 spaces",
	})

-- Clear search highlight
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear search highlight", })

-- Paste without overwriting clipboard
vim.keymap.set({"n", "v"}, "x", '"_x')
vim.keymap.set({"n", "v"}, "c", '"_c')
vim.keymap.set({"n", "v"}, "C", '"_C')
vim.keymap.set({"n", "v"}, "s", '"_s')
vim.keymap.set({"n", "v"}, "S", '"_S')
vim.keymap.set("x", "p", [["_dP]])
