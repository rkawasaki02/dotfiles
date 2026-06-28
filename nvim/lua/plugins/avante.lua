return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = { file_types = { "markdown", "Avante" } },
			ft = { "markdown", "Avante" },
		},
	},
	opts = {
		-- デフォルトプロバイダ（:AvanteSwitchProvider <name> で切り替え可能）
		--provider = "ollama",
		provider = "zai",
		providers = {
			-- ローカル: GALLERIA 上の Ollama（Tailscale 経由）
			ollama = {
				endpoint = os.getenv("OLLAMA_HOST"),
				model = "qwen3:14b",
				timeout = 60000,
				extra_request_body = {
					options = {
						temperature = 0.2,
						num_ctx = 32768,
					},
				},
			},

			-- OpenAI（GPT-5 / GPT-5.2 など、Codex 相当）
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-5.2", -- 要検証: 利用可能モデル名は OpenAI のダッシュボードで確認
				api_key_name = "OPENAI_API_KEY",
				timeout = 60000,
				extra_request_body = {
					temperature = 0.2,
					max_completion_tokens = 16384,
					-- reasoning_effort = "medium", -- reasoning モデル使用時のみ
				},
			},

			-- Z.ai（GLM-5.2 / GLM-4.7 など）OpenAI 互換エンドポイント
			zai = {
				__inherited_from = "openai",
				endpoint = "https://api.z.ai/api/paas/v4",
				api_key_name = "ZAI_API_KEY",
				model = "glm-5.2",
				timeout = 60000,
				extra_request_body = {
					temperature = 0.2,
					max_tokens = 16384,
				},
			},

			-- Anthropic（Claude） おまけ。AWS Bedrock 経由にしたいなら別途 bedrock プロバイダがある
			claude = {
				endpoint = "https://api.anthropic.com",
				api_key_name = "ANTHROPIC_API_KEY",
				model = "claude-opus-4-7", -- 要検証: 最新モデル名は Anthropic ドキュメント参照
				timeout = 60000,
				extra_request_body = {
					temperature = 0.2,
					max_tokens = 16384,
				},
			},

			-- OpenRouter（複数モデルを 1 つの API キーで切り替えたい場合のハブ）
			openrouter = {
				__inherited_from = "openai",
				endpoint = "https://openrouter.ai/api/v1",
				api_key_name = "OPENROUTER_API_KEY",
				model = "anthropic/claude-opus-4.7",
				timeout = 60000,
			},
		},

		mappings = {
			ask = "<leader>aq",
			edit = "<leader>ar",
			refresh = "<leader>aR",
			toggle = {
				default = "<leader>at",
				debug = "<leader>aTd",
				hint = "<leader>aTh",
				suggestion = "<leader>aTs",
				repomap = "<leader>aTm",
			},
		},
	},
}
