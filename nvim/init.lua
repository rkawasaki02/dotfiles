vim.opt.number = true         -- 絶対行（カーソル行の行番号）を表示
vim.opt.relativenumber = true -- カーソル行以外を相対行（1, 2, 3...）に設定

-- 2. leaderキーの設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 3. lazy.nvim の自動インストール
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- 4. プラグイン読み込み
require("lazy").setup("plugins")

-- 5. WezTerm連携（既存）
vim.api.nvim_create_autocmd({ "VimEnter", "VimLeave" }, {
	callback = function()
		local is_enter = vim.v.event_name == "VimEnter"
		local encoded = vim.base64.encode(is_enter and "true" or "false")
		io.stdout:write("\x1b]1337;SetUserVar=IS_NVIM=" .. encoded .. "\x07")
	end,
})

-- 6. クリップボード同期
vim.opt.clipboard = "unnamedplus"
