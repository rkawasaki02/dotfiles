return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua       = { "stylua" },
				terraform = { "terraform_fmt" },
				hcl       = { "terraform_fmt" },
				yaml      = { "prettierd", "prettier", stop_after_first = true },
				python    = { "black", "isort", stop_after_first = false },
			},
			-- 保存時に自動整形を実行
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
}
