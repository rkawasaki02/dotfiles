return {
  {
    'Saghen/blink.cmp',
    version = '*',
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      -- 補完窓の見た目を少しIDE風にする
      completion = {
        menu = { border = 'rounded' },
        documentation = { window = { border = 'rounded' } },
      },
    },
  }
}
