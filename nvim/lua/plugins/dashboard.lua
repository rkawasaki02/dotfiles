return {
	{
		"goolord/alpha-nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			local logo = {
				"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
				"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
				"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
				"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
				"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
				"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
			}

			for k, v in ipairs(logo) do
				logo[k] = "    " .. v .. "    "
			end
			dashboard.section.header.val = logo
			dashboard.section.header.opts.hl = "Keyword"

			local function get_recent_files()
				local buttons = {}
				local oldfiles = vim.v.oldfiles
				local count = 0
				for _, file in ipairs(oldfiles) do
					if count >= 5 then break end
					if vim.fn.filereadable(file) == 1 then
						local filename = vim.fn.fnamemodify(file, ":t")
						local icon, _ = require("nvim-web-devicons").get_icon(file,
							vim.fn.fnamemodify(file, ":e"), { default = true })
						local b = dashboard.button(tostring(count + 1), icon .. "  " .. filename,
							":e " .. file .. "<CR>")
						table.insert(buttons, b)
						count = count + 1
					end
				end
				if count == 0 then
					table.insert(buttons, dashboard.button("n", "󰈚  No recent files", ""))
				end
				local explorer_btn = dashboard.button("e", "  Explorer", "")
				explorer_btn.opts.keyval = "e"
				explorer_btn.on_press = function()
					require("oil").open()
				end
				table.insert(buttons, explorer_btn)
				return buttons
			end

			dashboard.section.buttons.val = get_recent_files()
			dashboard.section.footer.val = "⚡ loading..."
			dashboard.section.footer.opts.hl = "Comment"

			alpha.setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				once = true,
				callback = function()
					local stats = require("lazy").stats()
					dashboard.section.footer.val = "⚡ Neovim loaded in " ..
					string.format("%.2f", stats.startuptime) .. "ms"
					pcall(vim.cmd, "AlphaRedraw")
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					local row = #dashboard.section.header.val + 2
					pcall(vim.api.nvim_win_set_cursor, 0, { row, 0 })
				end,
			})
		end,
	},
}
