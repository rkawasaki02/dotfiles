return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			signs = true,
			keywords = {
				FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				NOTE = { icon = " ", color = "hint",    alt = { "INFO" } },
			},
		},
		keys = {
			{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
		},
	},
}
