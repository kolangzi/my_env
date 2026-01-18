local opt = vim.opt

-- tab/indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.autoindent = true
opt.smartindent = true
opt.wrap = false -- 줄바꿈 금지

-- search
opt.incsearch = true

-- visual
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = "100"
opt.signcolumn = "yes" -- 번호 왼쪽에 정보표시 공간

-- windows
opt.splitright = true

-- etc
opt.backspace = { "indent", "eol", "start" }
opt.encoding = "UTF-8"
opt.cmdheight = 1 -- 명령어 입력창 높이
opt.scrolloff = 8
opt.mouse:append("a")

-- undo/backup
opt.swapfile = false     -- 스왑파일은 끄고 (보통 불필요)
opt.backup = false       -- 백업파일도 끄고 (요즘은 git이 있으니)
opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- 저장할 위치 지정
opt.undofile = true      -- Undo 파일 생성 활성화

opt.clipboard = "unnamedplus" -- 시스템 클립보드 사용
