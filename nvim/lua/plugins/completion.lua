return {
	{
		'Saghen/blink.cmp',
		version = '*',
		opts = {
			-- キーマップ設定
			keymap = {
				-- preset を指定しつつ、個別のキーを上書きします
				preset = 'default',
				['<CR>'] = { 'accept', 'fallback' }, -- Enterで確定
				['<Tab>'] = { 'select_next', 'fallback' },
				['<S-Tab>'] = { 'select_prev', 'fallback' },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},
			completion = {
				menu = { border = 'rounded' },
				documentation = { window = { border = 'rounded' } },
			},
		},
	}
}
