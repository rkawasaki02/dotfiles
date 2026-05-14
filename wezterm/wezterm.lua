-- --------------------
-- メイン設定
-- --------------------

local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- 設定変更を即反映
config.automatically_reload_config = true
-- 日本語入力（macOS）
config.use_ime = true
-- フォント（日本語フォールバックつき）
config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono" },
	{ family = "Hiragino Sans" },
})
config.font_size = 13.0
config.color_scheme = "AdventureTime"
config.text_background_opacity = 1.0
-- 背景を少し透過
config.window_background_opacity = 0.7
config.macos_window_background_blur = 20
-- タブバーの上部のタイトルバーを削除
config.window_decorations = "RESIZE"
-- タブが1つの時はタブバーを非表示
config.hide_tab_bar_if_only_one_tab = true
-- タブの+とバツを消す
config.show_new_tab_button_in_tab_bar = false
-- バックスラッシュ入力
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
}

config.window_background_gradient = {
	colors = { "#000000" },
}

-- タブ同士の境界線を非表示
config.colors = {
	tab_bar = {
		inactive_tab_edge = "none",
	},
}

-- アクティブタブに色をつける
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"

	if tab.is_active then
		background = "#3d59a1"
		foreground = "#c0caf5"
	end

	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
	}
end)

-- Neovim(smart-splits)と連携するための判断関数
local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == 'true'
end

local function split_nav(key, direction)
	return {
		key = key,
		mods = 'CTRL',
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				win:perform_action({ SendKey = { key = key, mods = 'CTRL' } }, pane)
			else
				win:perform_action({ ActivatePaneDirection = direction }, pane)
			end
		end),
	}
end

config.keys = {
	-- Ctrl+hjkl: smart-splitsと連携
	split_nav('h', 'Left'),
	split_nav('j', 'Down'),
	split_nav('k', 'Up'),
	split_nav('l', 'Right'),

	-- Cmd+数字: タブ番号で直接切り替え
	{ key = "1", mods = "SUPER", action = act.ActivateTab(0) },
	{ key = "2", mods = "SUPER", action = act.ActivateTab(1) },
	{ key = "3", mods = "SUPER", action = act.ActivateTab(2) },
	{ key = "4", mods = "SUPER", action = act.ActivateTab(3) },
	{ key = "5", mods = "SUPER", action = act.ActivateTab(4) },
}

return config
