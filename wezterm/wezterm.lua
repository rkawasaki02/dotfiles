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
-- +を消す
config.show_new_tab_button_in_tab_bar = false
-- バックスラッシュ入力
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

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
