vim.g.mapleader = " " -- global leader
vim.g.maplocalleader = " " -- local leader
vim.opt.ttimeoutlen = 10 -- Terminal key code timeout to 10ms
vim.opt.timeoutlen = 500  -- General mapping timeout to 500ms
vim.opt.redrawtime = 1500 -- Redraw time for complex syntax highlighting
vim.opt.lazyredraw = true -- Make macros and regex faster by not redrawing
-- if vim.fn.has('nvim-0.10') == 1 then
-- 	vim.g.clipboard = {
-- 		name = 'OSC 52',
-- 		copy = {
-- 			['+'] = require('vim.ui.clipboard.osc52').copy('+'),
-- 			['*'] = require('vim.ui.clipboard.osc52').copy('*'),
-- 		},
-- 		paste = {
-- 			['+'] = require('vim.ui.clipboard.osc52').paste('+'),
-- 			['*'] = require('vim.ui.clipboard.osc52').paste('*'),
-- 		},
-- 	}
-- end

local is_tmux = os.getenv("TMUX") ~= nil
if vim.fn.has('nvim-0.10') == 1 then
	local paste_plus, paste_star

	if is_tmux then
		paste_plus = function()
			local contents = vim.fn.getreg('"')
			return { vim.fn.split(contents, '\n'), vim.fn.getregtype('"') }
		end
		paste_star = function()
			local contents = vim.fn.getreg('"')
			return { vim.fn.split(contents, '\n'), vim.fn.getregtype('"') }
		end
	else
		paste_plus = require('vim.ui.clipboard.osc52').paste('+')
		paste_star = require('vim.ui.clipboard.osc52').paste('*')
	end

	vim.g.clipboard = {
		name = 'OSC 52',
		copy = {
			['+'] = require('vim.ui.clipboard.osc52').copy('+'),
			['*'] = require('vim.ui.clipboard.osc52').copy('*'),
		},
		paste = {
			['+'] = paste_plus,
			['*'] = paste_star,
		},
	}
end
