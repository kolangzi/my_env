vim.g.mapleader = " " -- global leader
vim.g.maplocalleader = " " -- local leader

-- 내장 OSC 52를 클립보드 제공자로 설정
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
-- SSH 환경 여부 체크
local is_ssh = os.getenv("SSH_CONNECTION") ~= nil
-- if vim.fn.has('nvim-0.10') == 1 then
-- 	vim.g.clipboard = {
-- 		name = 'OSC 52',
-- 		copy = {
-- 			-- 복사(y)는 OSC 52를 통해 Mac 클립보드로 보냅니다.
-- 			['+'] = require('vim.ui.clipboard.osc52').copy('+'),
-- 			['*'] = require('vim.ui.clipboard.osc52').copy('*'),
-- 		},
-- 		paste = {
-- 			-- 붙여넣기(p)는 Mac에 요청하지 않고 서버 내부의 내용을 사용합니다.
-- 			['+'] = function()
-- 				if is_ssh then
-- 					-- [수정] + 대신 무명 레지스터(")의 내용을 가져와서 즉시 붙여넣음
-- 					local contents = vim.fn.getreg('"')
-- 					return { vim.fn.split(contents, '\n'), vim.fn.getregtype('"') }
-- 				end
-- 				-- 로컬 Mac 환경에서는 정상적으로 시스템 클립보드 사용
-- 				return require('vim.ui.clipboard.osc52').paste('+')
-- 			end,
-- 			['*'] = function()
-- 				if is_ssh then
-- 					local contents = vim.fn.getreg('"')
-- 					return { vim.fn.split(contents, '\n'), vim.fn.getregtype('"') }
-- 				end
-- 				return require('vim.ui.clipboard.osc52').paste('*')
-- 			end,
-- 		},
-- 	}
-- end

if vim.fn.has('nvim-0.10') == 1 then
  -- 환경에 따라 paste에 할당할 값을 미리 결정합니다.
  local paste_plus, paste_star

  if is_ssh then
    -- SSH 환경: Mac에 요청하지 않고 서버 내부 레지스터(")를 사용하도록 함수 정의
    paste_plus = function()
      local contents = vim.fn.getreg('"')
      return { vim.fn.split(contents, '\n'), vim.fn.getregtype('"') }
    end
    paste_star = function()
      local contents = vim.fn.getreg('"')
      return { vim.fn.split(contents, '\n'), vim.fn.getregtype('"') }
    end
  else
    -- 로컬 Mac 환경: 원하셨던 원래의 코드를 그대로 실행하여 할당합니다.
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
