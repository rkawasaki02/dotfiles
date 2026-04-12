return {
	{
		'mrjones2014/smart-splits.nvim',
		lazy = false,
		opts = {},
		keys = {
			-- Ctrl + hjkl でウィンドウ・ペインを移動
			{ '<C-h>', function() require('smart-splits').move_cursor_left() end,  desc = "Move left" },
			{ '<C-j>', function() require('smart-splits').move_cursor_down() end,  desc = "Move down" },
			{ '<C-k>', function() require('smart-splits').move_cursor_up() end,    desc = "Move up" },
			{ '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = "Move right" },
		},
	},
}
