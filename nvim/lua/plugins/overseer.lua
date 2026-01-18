return {
	"stevearc/overseer.nvim",
	opts = {
		strategy = "jobstart",
		templates = { "builtin" },
	},
	config = function(_, opts)
		local overseer = require("overseer")
		overseer.setup(opts)

		-- [1] 최상위 Makefile에서 타겟(all, clean 등)을 추출하는 함수
		local function get_root_makefile_targets()
			local targets = {}
			local makefile_path = vim.fn.getcwd() .. "/Makefile"
			local f = io.open(makefile_path, "r")
			if not f then return targets end

			for line in f:lines() do
				-- .PHONY가 아니면서 단어: 형태인 라인을 찾아 타겟으로 인식
				local target = line:match("^([%w%-_]+):")
				if target and target ~= ".PHONY" then
					table.insert(targets, target)
				end
			end
			f:close()
			return targets
		end

		-- [2] 추출된 최상위 타겟들을 Overseer에 하나씩 등록
		local root_targets = get_root_makefile_targets()
		for _, target in ipairs(root_targets) do
			overseer.register_template({
				name = "make " .. target .. " (Root)",
				builder = function()
					return {
						cmd = { "make" },
						args = { target },
						cwd = vim.fn.getcwd(), -- 무조건 최상위에서 실행
						components = { "default" },
					}
				end,
				priority = 1, -- 우선순위 높임
			})
		end

		-- [3] wang_build.sh 즉시 실행 함수 (ow)
		local function run_wang_wrapper()
			local script = "./wang_build.sh"
			if vim.fn.filereadable(script) == 1 then
				local tasks = overseer.list_tasks({ name = "Wang Wrapper" })
				if #tasks > 0 then
					tasks[1]:restart()
				else
					overseer.new_task({
						cmd = { script },
						name = "Wang Wrapper",
						components = { "default" },
					}):start()
				end
				overseer.open({ enter = false })
			else
				vim.notify("wang_build.sh 파일이 없습니다.", vim.log.levels.ERROR)
			end
		end

		-- [4] 커스텀 빌드 명령 입력 실행 함수 (oc)
		local function run_custom_build()
			vim.ui.input({
				prompt = "Custom Build Command: ",
				default = "", -- 자주 쓰는 기본값 제공
				completion = "file",      -- 파일 경로 자동완성 지원
			}, function(input)
					if not input or input == "" then return end

					-- 입력된 문자열을 공백 기준으로 분리하여 명령어와 인자로 나눕니다.
					local cmd_parts = vim.split(input, " ")

					local task = overseer.new_task({
						cmd = cmd_parts,
						name = "Custom: " .. input,
						components = { "default" },
						cwd = vim.fn.getcwd(),
					})
					task:start()
					overseer.open({ enter = false })
				end)
		end

		-- [5] 퀵 액션 실행 함수 (oq)
		local function restart_last_task()
			-- 최근 작업 순으로 태스크 목록을 가져옴
			local tasks = overseer.list_tasks({ recent_first = true })

			if #tasks == 0 then
				vim.notify("재시작할 태스크가 없습니다.", vim.log.levels.WARN)
				return
			end

			-- [핵심] 메뉴를 띄우지 않고 가장 최근 태스크(tasks[1])를 즉시 재시작합니다.
			tasks[1]:restart()

			-- 재시작 시 사이드바가 닫혀있다면 열어줍니다.
			overseer.open({ enter = false })
		end

		-- [6] 단축키 설정
		vim.keymap.set("n", "<leader>ow", run_wang_wrapper, { desc = "Run ./wang_build.sh" })
		vim.keymap.set("n", "<leader>oc", run_custom_build, { desc = "Run Custom Command" })
		vim.keymap.set("n", "<leader>oq", restart_last_task, { desc = "Restart Last Task" })
		vim.keymap.set("n", "<leader>or", function()
			overseer.run_task({ autoselect = false }, function(task)
				if task then
					vim.schedule(function()
						overseer.open({ enter = false })
					end)
				end
			end)
		end, { desc = "Run Built-in Task" })
		vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<cr>", { desc = "Task List" })
	end,
}
