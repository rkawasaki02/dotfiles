# dotfiles

Personal dotfiles for Neovim and WezTerm.

## Structure

```
.config/
├── nvim/
│   ├── init.lua
│   └── lua/plugins/
│       ├── autopairs.lua
│       ├── comment.lua
│       ├── completion.lua
│       ├── dashboard.lua
│       ├── editor.lua
│       ├── formatting.lua
│       ├── git.lua
│       ├── indent.lua
│       ├── lsp.lua
│       ├── smart-splits.lua
│       ├── todo-comments.lua
│       ├── treesitter.lua
│       ├── ui.lua
│       └── whichkey.lua
└── wezterm/
    └── wezterm.lua
```

## Neovim Plugins

| Plugin | 説明 |
|--------|------|
| tokyonight.nvim | カラーテーマ |
| lualine.nvim | ステータスライン |
| alpha-nvim | ダッシュボード |
| indent-blankline.nvim | インデント可視化 |
| nvim-treesitter | シンタックスハイライト |
| nvim-autopairs | 括弧自動補完 |
| Comment.nvim | コメントトグル |
| blink.cmp | 補完 |
| conform.nvim | 自動フォーマット |
| nvim-lspconfig | LSP設定 |
| mason.nvim | LSPインストール管理 |
| oil.nvim | ファイルエクスプローラー |
| telescope.nvim | ファジーファインダー |
| gitsigns.nvim | git差分表示 |
| vim-fugitive | git操作 |
| which-key.nvim | キーマップ一覧 |
| smart-splits.nvim | ウィンドウ・ペイン移動 |
| todo-comments.nvim | TODOハイライト |

## LSP

- `lua_ls` - Lua
- `terraformls` - Terraform
- `yamlls` - YAML / CloudFormation
- `pyright` - Python

## Formatters

- `stylua` - Lua
- `terraform_fmt` - Terraform / HCL
- `prettier` - YAML
- `black` + `isort` - Python

## Key Mappings

### General

| Key | Action |
|-----|--------|
| `Space+a` | ダッシュボード |
| `Space+r` | ファイル実行 |
| `Space+sv` | 縦分割 |
| `Space+sh` | 横分割 |
| `Space+sc` | 分割を閉じる |
| `jk` | ノーマルモードに戻る |

### File

| Key | Action |
|-----|--------|
| `-` | ファイルエクスプローラー |
| `Space+ff` | ファイル検索 |
| `Space+fg` | 全文検索 |
| `Space+ft` | TODO一覧 |

### LSP

| Key | Action |
|-----|--------|
| `gd` | 定義ジャンプ |
| `K` | ホバー |
| `Space+rn` | リネーム |
| `Space+ca` | コードアクション |

### Git

| Key | Action |
|-----|--------|
| `Space+gs` | Git status |
| `Space+gd` | Git diff |
| `Space+gb` | Git blame |
| `Space+gc` | Git commit |
| `Space+gp` | Git push |
| `Space+gl` | Git pull |

### Window / Pane

| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | ウィンドウ・WezTermペイン移動 |

## WezTerm

- フォント: JetBrains Mono + Hiragino Sans（日本語フォールバック）
- カラースキーム: AdventureTime
- 背景透過: 70%
- Neovim との smart-splits 連携済み

## Shell (zsh)

- `zsh-autosuggestions` - 履歴から薄文字で候補表示
- `zsh-syntax-highlighting` - コマンドの色付け
- `fzf` - 履歴検索（Ctrl+R）
- `fzf-tab` - Tab補完をfzfで表示
- `zoxide` - 賢いcd

### zsh Key Mappings

| Key | Action |
|-----|--------|
| `Ctrl+f` | 薄文字候補を確定 |
| `Ctrl+R` | 履歴検索 |
| `Tab` | 補完候補一覧 |
