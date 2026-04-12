return {
	{
		'Saghen/blink.cmp',
		version = '*',
		opts = {
			keymap = {
				preset        = 'none',
				['<CR>']      = { 'accept', 'fallback' },
				-- メニューが既に出ているときだけ上下移動、それ以外は普通のTab
				['<Tab>']     = { 'select_next', 'fallback' },
				['<S-Tab>']   = { 'select_prev', 'fallback' },
				['<Esc>']     = { 'hide', 'fallback' },
				['<C-Space>'] = { 'show' }, -- 手動で補完を出したいときだけ
				['<C-e>']     = { 'hide' },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono',
			},
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},
			completion = {
				-- 補完メニューは文字を打ったときだけ自動表示（Tabでは開かない）
				trigger = {
					show_on_insert_on_trigger_character = true,
					show_on_keyword = true,
					show_on_trigger_character = true,
				},
				list = { selection = { preselect = false, auto_insert = false } },
				menu = { border = 'rounded' },
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = 'rounded' },
				},
			},
		},
	},
}
