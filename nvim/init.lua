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

-- バックアップ・スワップファイルを作らない
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
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#585858" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#EBCB8B", bold = true })

	vim.api.nvim_set_hl(0, "CursorNormal", { bg = "#88C0D0", fg = "black" }) -- 水色
	vim.api.nvim_set_hl(0, "CursorInsert", { bg = "#A3BE8C", fg = "black" }) -- あか
	vim.api.nvim_set_hl(0, "CursorVisual", { bg = "#B48EAD", fg = "black" }) -- ピンク
	vim.api.nvim_set_hl(0, "CursorCommand", { bg = "#D08770", fg = "black" }) -- オレンジ
end

set_custom_hl()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_custom_hl })

vim.opt.guicursor = "n-c:block-CursorNormal,i:ver25-CursorInsert,v:block-CursorVisual"

-- ==========================================================================
-- 4. ウィンドウ分割キーマップ
-- ==========================================================================
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "縦分割" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<cr>", { desc = "横分割" })
vim.keymap.set("n", "<leader>sc", "<cmd>close<cr>", { desc = "分割を閉じる" })

-- ==========================================================================
-- 5. WezTerm連携 (smart-splits用)
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
