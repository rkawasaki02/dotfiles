return {
	-- Oil.nvim: ファイルエクスプローラー（"-"キーで起動、dashboardのeキーでも起動）
	{
		"stevearc/oil.nvim",
		lazy = false, -- dashboardから呼べるよう起動時に読み込む
		opts = {
			default_file_explorer = true,
			columns = { "icon" },
			view_options = { show_hidden = true },
		},
		keys = {
			{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
		},
	},
	-- Telescope: 曖昧検索（スペース+ff でファイル検索 / スペース+fg で全文検索）
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
		},
		opts = {
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
					},
				},
			},
		},
	},
}
