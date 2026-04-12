-- ==========================================================================
-- 1. 基本設定
-- ==========================================================================
vim.opt.number = true         -- 行番号表示
vim.opt.relativenumber = true -- 相対行番号
vim.opt.cursorline = true     -- カーソル行ハイライト
vim.opt.termguicolors = true  -- 24bitカラー
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.undofile = true

-- not backup
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- ゴミファイル防止
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- ==========================================================================
-- 2. Leaderキーとプラグイン管理 (ここを先に書くのが安全)
-- ==========================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
		lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- ==========================================================================
-- 3. 見た目・モード別カーソルの設定
-- ==========================================================================

local function set_custom_hl()
	-- 行番号の色（ここでお好みの色に調整可能）
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#585858" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#EBCB8B", bold = true })

	-- モード別カーソルの色定義
	vim.api.nvim_set_hl(0, "CursorNormal", { bg = "#88C0D0", fg = "black" }) -- 水色
	vim.api.nvim_set_hl(0, "CursorInsert", { bg = "#A3BE8C", fg = "black" }) -- 緑
	vim.api.nvim_set_hl(0, "CursorVisual", { bg = "#B48EAD", fg = "black" }) -- ピンク
	vim.api.nvim_set_hl(0, "CursorCommand", { bg = "#D08770", fg = "black" }) -- オレンジ
end

-- 適用
set_custom_hl()
-- テーマ変更時にも色が消えないようにする
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_custom_hl })

-- カーソル形状の設定
vim.opt.guicursor = "n-c:block-CursorNormal,i:ver25-CursorInsert,v:block-CursorVisual"

-- ==========================================================================
-- 4. WezTerm連携 (smart-splits用)
-- ==========================================================================
local function set_wezterm_user_var(name, value)
	io.stdout:write(string.format("\x1b]1337;SetUserVar=%s=%s\x07", name, vim.base64.encode(value)))
end

local wez_group = vim.api.nvim_create_augroup("WeztermVars", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
	group = wez_group,
	callback = function() set_wezterm_user_var("IS_NVIM", "true") end,
})
vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
	group = wez_group,
	callback = function() set_wezterm_user_var("IS_NVIM", "false") end,
})
