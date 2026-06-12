-- 対象のファイルタイプ（パーサー名とfiletypeが一致するものだけを列挙）
local languages = {
	"lua",
	"terraform",
	"hcl",
	"yaml",
	"python",
	"json",
	"markdown",
	"bash",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			-- mainブランチではensure_installedは廃止され、install()でパーサーを導入する
			require("nvim-treesitter").install(languages)

			-- ハイライト・インデントはFileTypeごとに明示的に有効化する
			vim.api.nvim_create_autocmd("FileType", {
				pattern = languages,
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
