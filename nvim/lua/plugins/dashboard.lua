return {
	{
		"goolord/alpha-nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- ==========================================================
			-- ヘッダー（行ごとにグラデーションをかけたロゴ）
			-- ==========================================================
			local logo = {
				"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
				"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
				"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
				"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
				"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
				"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
			}
			local gradient = { "#7dcfff", "#7aa2f7", "#bb9af7", "#9d7cd8", "#7aa2f7", "#2ac3de" }

			local function set_header_hl()
				for i, color in ipairs(gradient) do
					vim.api.nvim_set_hl(0, "AlphaHeader" .. i, { fg = color, bold = true })
				end
			end
			set_header_hl()
			vim.api.nvim_create_autocmd("ColorScheme", { callback = set_header_hl })

			local header = {}
			for i, line in ipairs(logo) do
				table.insert(header, {
					type = "text",
					val = line,
					opts = { hl = "AlphaHeader" .. i, position = "center" },
				})
			end

			-- ==========================================================
			-- あいさつ + 日時
			-- ==========================================================
			local function greeting()
				local hour = tonumber(os.date("%H"))
				local user = vim.env.USER or "user"
				local msg
				if hour < 5 then
					msg = "夜更かしですね"
				elseif hour < 11 then
					msg = "おはようございます"
				elseif hour < 18 then
					msg = "こんにちは"
				else
					msg = "こんばんは"
				end
				local t = os.date("*t")
				local wdays = { "日", "月", "火", "水", "木", "金", "土" }
				return string.format("%s、%s さん 󰃭 %d/%02d/%02d (%s) 󰥔 %02d:%02d",
					msg, user, t.year, t.month, t.day, wdays[t.wday], t.hour, t.min)
			end

			-- ==========================================================
			-- クイックアクション
			-- ==========================================================
			-- telescope / nvim-tree は遅延読み込みのため、コマンドではなく
			-- require経由で呼ぶ（lazy.nvimがrequire時に自動ロードする）
			local actions = {
				{ type = "text",    val = "⚡ Quick Actions", opts = { hl = "SpecialComment", position = "center" } },
				{ type = "padding", val = 1 },
				dashboard.button("n", "  New file", ":enew | startinsert<CR>"),
				dashboard.button("f", "  Find file", ":lua require('telescope.builtin').find_files()<CR>"),
				dashboard.button("g", "󰱼  Grep text", ":lua require('telescope.builtin').live_grep()<CR>"),
				dashboard.button("e", "  Explorer (Oil)", ":Oil<CR>"),
				dashboard.button("t", "  File tree", ":lua require('nvim-tree.api').tree.toggle()<CR>"),
				dashboard.button("s", "  Git status", ":Git<CR>"),
				dashboard.button("l", "󰊢  LazyGit", ":LazyGit<CR>"),
				dashboard.button("d", "󰒡  Diagnostics", ":Trouble diagnostics toggle<CR>"),
				dashboard.button("c", "  Edit config", ":e $MYVIMRC<CR>"),
				dashboard.button("u", "󰚰  Update plugins", ":Lazy update<CR>"),
				dashboard.button("m", "  Mason", ":Mason<CR>"),
				dashboard.button("q", "  Quit", ":qa<CR>"),
			}

			-- ==========================================================
			-- 最近開いたファイル（数字キーで開く）
			-- ==========================================================
			local function mru_buttons()
				local buttons = {}
				local seen = {}
				local count = 0
				for _, file in ipairs(vim.v.oldfiles) do
					if count >= 8 then break end
					local path = vim.fn.fnamemodify(file, ":p")
					if vim.fn.filereadable(path) == 1
					    and not seen[path]
					    and not path:find("COMMIT_EDITMSG", 1, true) then
						seen[path] = true
						count = count + 1
						local display = vim.fn.fnamemodify(path, ":~")
						if vim.fn.strdisplaywidth(display) > 44 then
							display = "…" .. vim.fn.strcharpart(display, vim.fn.strchars(display) - 43)
						end
						local icon = require("nvim-web-devicons").get_icon(
							path, vim.fn.fnamemodify(path, ":e"), { default = true })
						table.insert(buttons, dashboard.button(
							tostring(count),
							icon .. "  " .. display,
							":e " .. vim.fn.fnameescape(path) .. "<CR>"
						))
					end
				end
				if count == 0 then
					table.insert(buttons, {
						type = "text",
						val = "（最近開いたファイルはありません）",
						opts = { hl = "Comment", position = "center" },
					})
				end
				return buttons
			end

			local mru = {
				type = "group",
				val = function()
					return {
						{ type = "text",    val = "  Recent Files", opts = { hl = "SpecialComment", position = "center" } },
						{ type = "padding", val = 1 },
						{ type = "group",   val = mru_buttons() },
					}
				end,
			}

			-- ==========================================================
			-- フッター（起動統計 + gitブランチ）
			-- ==========================================================
			local footer = {
				type = "text",
				val = "⚡ loading...",
				opts = { hl = "Comment", position = "center" },
			}

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				once = true,
				callback = function()
					local stats = require("lazy").stats()
					local v = vim.version()
					local parts = {
						string.format(" v%d.%d.%d", v.major, v.minor, v.patch),
						string.format("󰂖 %d/%d plugins", stats.loaded, stats.count),
						string.format("󱎫 %.1fms", stats.startuptime),
					}
					local branch = vim.fn.systemlist("git branch --show-current 2>/dev/null")[1]
					if vim.v.shell_error == 0 and branch and branch ~= "" then
						table.insert(parts, " " .. branch)
					end
					footer.val = table.concat(parts, "   ")
					pcall(vim.cmd.AlphaRedraw)
				end,
			})

			-- ==========================================================
			-- レイアウト組み立て
			-- ==========================================================
			local layout = { { type = "padding", val = 1 } }
			vim.list_extend(layout, header)
			vim.list_extend(layout, {
				{ type = "padding", val = 1 },
				{ type = "text",    val = greeting, opts = { hl = "String", position = "center" } },
				{ type = "padding", val = 2 },
			})
			vim.list_extend(layout, actions)
			vim.list_extend(layout, {
				{ type = "padding", val = 1 },
				mru,
				{ type = "padding", val = 1 },
				footer,
			})

			alpha.setup({
				layout = layout,
				opts = { margin = 5 },
			})
		end,
	},
}
