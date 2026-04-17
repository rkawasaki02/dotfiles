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
			indent = { enable = false }, -- treesitterのインデントを無効化
		},
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)
		end,
	},
}
