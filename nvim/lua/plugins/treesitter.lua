return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = {
				"lua",
				"terraform",
				"hcl",
				"yaml",
				"python",
				"json",
				"markdown",
				"bash",
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
		config = function(_, opts)
			-- v1.0以降は vim.treesitter で直接設定する
			require("nvim-treesitter").setup(opts)
		end,
	},
}
