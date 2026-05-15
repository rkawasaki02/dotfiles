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
			{ "<leader>gs", "<cmd>Git<cr>",                desc = "Git status" },
			{ "<leader>gd", "<cmd>Gdiffsplit<cr>",         desc = "Git diff" },
			{ "<leader>gb", "<cmd>Git blame<cr>",          desc = "Git blame" },
			{ "<leader>gp", "<cmd>Git push<cr>",           desc = "Git push" },
			{ "<leader>gl", "<cmd>Git pull<cr>",           desc = "Git pull" },
			{ "<leader>gc", "<cmd>Git commit<cr>",         desc = "Git commit" },
			{ "<leader>gf", "<cmd>Git fetch<cr>",          desc = "Git fetch" },
			{ "<leader>gr", "<cmd>Git rebase<cr>",         desc = "Git rebase" },
			{ "<leader>ga", "<cmd>Git commit --amend<cr>", desc = "Git amend" },
			-- 現在のブランチをoriginにpush（初回-u付き）
			{
				"<leader>gP",
				function()
					local branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
					vim.cmd("Git push -u origin " .. branch)
				end,
				desc = "Git push -u origin (current branch)",
			},
		},
	},
}
