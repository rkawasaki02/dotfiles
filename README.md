# dotfiles

macOS用の個人開発環境設定（WezTerm + Neovim）。

## 概要

WezTerm（ターミナル）と Neovim（エディタ）を中心とした開発環境です。

- **ターミナル**: WezTerm — タブ管理、Neovimとのシームレスなペイン移動（smart-splits連携）
- **エディタ**: Neovim — lazy.nvim によるプラグイン管理、LSP・自動フォーマット・Git連携込み
- **テーマ**: Tokyo Night（WezTerm / Neovim で統一）
- **主な対象言語**: Terraform / HCL、YAML（CloudFormation）、Python、Lua、Bash

リーダーキーは `Space` です。`Space` を押して少し待つと which-key がキーマップ一覧をポップアップ表示するので、操作を忘れても大丈夫です。

> [!IMPORTANT]
> **WezTerm は nightly 版を使ってください。** 安定版 `20240203` には、Neovim 0.11+ の縦分割スクロール（DECSLRM 左右マージン）の左端境界を正しく処理できないバグがあり、右ウィンドウをスクロールすると左ウィンドウの表示が崩れます（[neovim/neovim#34120](https://github.com/neovim/neovim/issues/34120)、WezTerm側の修正: [wezterm#5871](https://github.com/wezterm/wezterm/pull/5871)）。

## この環境に必要なもの

| ツール | 用途 | 必須 |
|--------|------|------|
| [Homebrew](https://brew.sh/) | パッケージ管理 | ✅ |
| WezTerm（**nightly**） | ターミナル | ✅ |
| Neovim 0.11+ | エディタ | ✅ |
| git | バージョン管理・プラグイン取得 | ✅ |
| JetBrains Mono | フォント（アイコンはWezTerm内蔵のNerd Fontシンボルで表示） | ✅ |
| ripgrep | Telescope の全文検索（`Space+fg`） | ✅ |
| lazygit | Git TUI（`Space+lg`） | ✅ |
| Node.js | prettierd・yamlls などの実行に必要 | ✅ |
| Python 3 | pyright・black などの実行に必要 | ✅ |
| terraform | `terraform fmt` によるフォーマット | Terraformを書くなら |

LSPサーバー（lua_ls / terraformls / yamlls / pyright / typos_lsp）とフォーマッタ（stylua / prettierd / black / isort）は、Neovim 初回起動時に **Mason が自動インストール**するので個別に入れる必要はありません。

## インストール手順

### 1. Homebrew のインストール（未導入の場合）

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. 必要なツールのインストール

```sh
# ターミナル（必ず nightly を入れること。安定版は縦分割スクロールにバグあり）
brew install --cask wezterm@nightly

# エディタと周辺ツール
brew install neovim git ripgrep lazygit node

# フォント
brew install --cask font-jetbrains-mono

# Terraform を書く場合
brew install terraform
```

### 3. この設定のクローン

```sh
# 既存の ~/.config がある場合は退避
mv ~/.config ~/.config.bak 2>/dev/null

git clone <このリポジトリのURL> ~/.config
```

### 4. Neovim の初回セットアップ

```sh
nvim
```

初回起動時に自動で以下が行われます（数分かかります）:

1. lazy.nvim（プラグインマネージャ）のブートストラップ
2. 全プラグインのインストール
3. Mason による LSP サーバーのインストール（`lua_ls` / `terraformls` / `yamlls` / `pyright` / `typos_lsp`）
4. treesitter パーサーのインストール

フォーマッタは一度だけ手動でインストールします:

```vim
:MasonInstall stylua prettierd black isort
```

完了したら `:checkhealth` で問題がないか確認できます。

### 5. WezTerm の起動

WezTerm を起動すれば `~/.config/wezterm/wezterm.lua` が自動で読み込まれます。設定変更は保存と同時に反映されます（`automatically_reload_config`）。

### 6. zsh プラグイン（任意）

```sh
brew install zsh-autosuggestions zsh-syntax-highlighting fzf fzf-tab zoxide
```

## 操作方法

リーダーキーは `Space` です。`Space` 押下後に which-key が候補を表示します（`Space+?` で現在のバッファのキーマップ一覧）。

### 基本

| キー | 動作 |
|------|------|
| `Space+a` | ダッシュボードを開く |
| `Space+r` | 現在のファイルを実行（Python / Lua / Bash） |
| `Space+tn` | ターミナルを分割で開く |
| `jk` | ノーマルモードに戻る（挿入・ビジュアル・ターミナル） |

### ウィンドウ・ペイン

| キー | 動作 |
|------|------|
| `Space+sv` | 縦分割 |
| `Space+sh` | 横分割 |
| `Space+sc` | 分割を閉じる |
| `Ctrl+h/j/k/l` | ウィンドウ移動（Neovim⇔WezTermペインをシームレスに移動） |

### ファイル検索・エクスプローラー

| キー | 動作 |
|------|------|
| `-` | Oil（親ディレクトリをバッファとして編集） |
| `Space+e` | nvim-tree（サイドバー型ツリー）の開閉 |
| `Space+ff` | ファイル名検索（Telescope） |
| `Space+fg` | 全文検索（Telescope + ripgrep） |
| `Space+ft` | TODOコメント一覧 |

### コーディング（LSP・補完・診断）

| キー | 動作 |
|------|------|
| `gd` | 定義へジャンプ |
| `K` | ホバー（ドキュメント表示） |
| `Space+rn` | リネーム |
| `Space+ca` | コードアクション |
| `Space+xx` | 診断一覧（Trouble、プロジェクト全体） |
| `Space+xb` | 診断一覧（現在のバッファのみ） |
| `Tab` / `Shift+Tab` | 補完候補の移動 |
| `Enter` | 補完の確定 |
| `Ctrl+Space` | 補完メニューを手動表示 |

保存時に conform.nvim が自動フォーマットします。

### 編集

| キー | 動作 |
|------|------|
| `gcc` | 行コメントのトグル |
| `gbc` | ブロックコメントのトグル |
| `gc`（ビジュアル） | 選択範囲をコメント |
| `ys{motion}{char}` | 囲みを追加（例: `ysiw"` で単語を `"` で囲む） |
| `cs{old}{new}` | 囲みを変更（例: `cs'"` で `'` → `"`） |
| `ds{char}` | 囲みを削除 |

### Git

| キー | 動作 |
|------|------|
| `Space+lg` | LazyGit を開く |
| `Space+gs` | Git status（fugitive） |
| `Space+gd` | Git diff |
| `Space+gb` | Git blame |
| `Space+gc` | Git commit |
| `Space+gp` | Git push |
| `Space+gl` | Git pull |

行単位の差分は gitsigns がサインカラムに常時表示し、カーソル行には blame が表示されます。

### WezTerm

| キー | 動作 |
|------|------|
| `Cmd+1`〜`Cmd+5` | タブ切り替え |
| `Cmd+E` | タブ名の変更 |
| `Ctrl+h/j/k/l` | ペイン移動（Neovim内ではウィンドウ移動に切り替わる） |

### zsh

| キー | 動作 |
|------|------|
| `Ctrl+f` | 薄文字の履歴候補を確定 |
| `Ctrl+R` | fzf で履歴検索 |
| `Tab` | fzf-tab で補完候補一覧 |

## ディレクトリ構成

```
.config/
├── nvim/
│   ├── init.lua              # 基本設定・キーマップ・WezTerm連携
│   ├── lazy-lock.json        # プラグインのバージョン固定
│   └── lua/plugins/          # プラグイン定義（1ファイル1機能）
│       ├── autopairs.lua     # 括弧の自動補完
│       ├── comment.lua       # コメントトグル
│       ├── completion.lua    # 補完（blink.cmp）
│       ├── dashboard.lua     # 起動画面（alpha-nvim）
│       ├── editor.lua        # Oil / Telescope
│       ├── formatting.lua    # 自動フォーマット（conform.nvim）
│       ├── git.lua           # gitsigns / fugitive
│       ├── indent.lua        # インデント可視化
│       ├── lazygit.lua       # LazyGit連携
│       ├── lsp.lua           # LSP・Mason
│       ├── smart-splits.lua  # WezTermペインとの移動連携
│       ├── surround.lua      # 囲み編集（nvim-surround）
│       ├── todo-comment.lua  # TODOハイライト
│       ├── tree.lua          # nvim-tree
│       ├── treesitter.lua    # シンタックスハイライト
│       ├── trouble.lua       # 診断一覧
│       ├── ui.lua            # テーマ（tokyonight）/ lualine
│       └── whichkey.lua      # キーマップ一覧表示
└── wezterm/
    └── wezterm.lua           # WezTerm設定
```

## LSP / フォーマッタ

| 言語 | LSP | フォーマッタ |
|------|-----|--------------|
| Lua | lua_ls | stylua |
| Terraform / HCL | terraformls | terraform fmt |
| YAML / CloudFormation | yamlls（CFnスキーマ対応） | prettierd |
| Python | pyright | black + isort |
| 全ファイル共通 | typos_lsp（誤字検出） | - |

## トラブルシューティング

### 縦分割で片方をスクロールするともう片方の表示が崩れる

WezTerm が古い（安定版 `20240203`）ことが原因です。nightly 版に入れ替えてください:

```sh
brew uninstall --cask wezterm
brew install --cask wezterm@nightly
```

入れ替え後、WezTerm を再起動すれば直ります。`wezterm --version` が `20250518` 以降であればOKです。

### LSPが動かない / フォーマットされない

```vim
:checkhealth        " 全体の診断
:Mason              " LSP・フォーマッタのインストール状況
:LspInfo            " 現在のバッファにアタッチしているLSP
:ConformInfo        " 使用されるフォーマッタの確認
```

### プラグインの更新

```vim
:Lazy sync          " lazy-lock.json に合わせて同期
:Lazy update        " 最新版へ更新（lazy-lock.json も更新される）
:TSUpdate           " treesitterパーサーの更新
```
