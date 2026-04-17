return {
	-- 既存のgitsigns
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add    = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
			},
			current_line_blame = true,
		},
	},
	-- fugitive: Neovim内でgit操作を完結させる
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gdiffsplit", "Gblame", "Gpush", "Gpull" },
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>",        desc = "Git status" },
			{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff" },
			{ "<leader>gb", "<cmd>Git blame<cr>",  desc = "Git blame" },
			{ "<leader>gp", "<cmd>Git push<cr>",   desc = "Git push" },
			{ "<leader>gl", "<cmd>Git pull<cr>",   desc = "Git pull" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
		},
	},
}
