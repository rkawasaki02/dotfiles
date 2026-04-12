return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("Comment").setup()

			-- which-keyの表示が文字化けしないよう説明を上書き
			vim.keymap.set("n", "gcc", function() require("Comment.api").toggle.linewise.current() end,
				{ desc = "Toggle line comment" })
			vim.keymap.set("n", "gbc", function() require("Comment.api").toggle.blockwise.current() end,
				{ desc = "Toggle block comment" })

			local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
			vim.keymap.set("x", "gc", function()
				vim.api.nvim_feedkeys(esc, "nx", false)
				require("Comment.api").toggle.linewise(vim.fn.visualmode())
			end, { desc = "Toggle line comment (visual)" })
		end,
	},
}
