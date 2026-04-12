return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			-- 変更があった行の横に記号を表示
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
			},
			-- 行ごとの詳細（誰が書いたか）を薄く表示する設定
			current_line_blame = true,
		},
	},
}
