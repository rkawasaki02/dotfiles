return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "▏" },
			scope = { enabled = true, show_start = true },
			exclude = {
				-- ダッシュボードでは縦線を非表示
				filetypes = { "dashboard", "alpha", "lazy", "mason" },
			},
		},
	},
}
