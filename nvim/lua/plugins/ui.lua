return {
	-- カラースキーム（Tokyo Night）
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true, -- ここを true にすると背景が透明になります
			styles = {
				sidebars = "transparent", -- サイドバー（もしあれば）も透明に
				floats = "transparent", -- 浮いたウィンドウも透明に
			},
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	-- ステータスライン
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "tokyonight",
				section_separators = "",
				component_separators = "|",
			},
		},
	},
}
