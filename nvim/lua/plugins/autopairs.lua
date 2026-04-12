return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true, -- treesitterと連携して賢くペアを補完
		},
	},
}
