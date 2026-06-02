return {
	{
		"tekumara/typos-lsp",
		config = function()
			vim.lsp.config("typos_lsp", {
				init_options = {
					-- 誤字の重大度（hint/info/warning/error）
					diagnosticSeverity = "warning",
				},
			})
			vim.lsp.enable("typos_lsp")
		end,
	},
}
