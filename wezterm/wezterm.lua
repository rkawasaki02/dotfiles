-- --------------------
-- メイン設定
-- --------------------

-- WezTerm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- 設定変更を即反映
config.automatically_reload_config = true
-- 日本語入力（macOS）
config.use_ime = true
-- フォントサイズ
config.font_size = 13.0
config.color_scheme = "AdventureTime"
-- 背景を少し透過
config.window_background_opacity = 0.7
config.macos_window_background_blur = 20
-- タブバーの上部のタイトルバーを削除
config.window_decorations = "RESIZE"
-- タブの+とバツを消す
config.show_new_tab_button_in_tab_bar = false
-- config.show_close_tab_button_in_tabs = false
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

local function is_vim(pane)
	-- 現在のペインで nvim が動いているか判定
	return pane:get_user_vars().IS_NVIM == 'true'
end

local function direction_keys(key, direction)
	return {
		key = key,
		mods = 'CTRL',
		action = wezterm.action_callback(function(window, pane)
			if is_vim(pane) then
				-- Neovim内なら、そのままCtrl+keyを送信
				window:perform_action(wezterm.action.SendKey({ key = key, mods = 'CTRL' }), pane)
			else
				-- WezTerm内なら、ペインを移動
				window:perform_action(wezterm.action.ActivatePaneDirection(direction), pane)
			end
		end),
	}
end

config.keys = {
	direction_keys('h', 'Left'),
	direction_keys('j', 'Down'),
	direction_keys('k', 'Up'),
	direction_keys('l', 'Right'),
}

-- 設定を返す
return config
