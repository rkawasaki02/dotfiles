return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- Spaceから始まるキーマップをグループ名つきで一覧表示
			spec = {
				{ "<leader>f", group = "Find" },
				{ "<leader>g", group = "Git" },
				{ "<leader>s", group = "Split" },
				{ "<leader>t", group = "Terminal" },
				{ "<leader>x", group = "Diagnostics" },
			},
		},
		keys = {
			{
				"<leader>k",
				function() require("which-key").show() end,
				desc = "Keymaps",
			},
		},
	},
}
