return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 500,
			icons = { mappings = true },
			spec = {
				{ "<leader>f", group = "Find" },
				{ "<leader>r", group = "Rename" },
				{ "<leader>c", group = "Code" },
				{ "<leader>s", group = "Split" },
				{ "<leader>g", group = "Git" },
			},
		},
	},
}
