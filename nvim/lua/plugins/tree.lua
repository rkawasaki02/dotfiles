return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	-- ディレクトリを開く役目はoil.nvimに任せ、キーを押したときだけ読み込む
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "TreeToggle" },
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {}
	end,
}
