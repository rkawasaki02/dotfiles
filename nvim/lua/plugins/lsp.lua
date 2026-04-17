return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- 1. Mason でバイナリを管理
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "terraformls", "yamlls", "pyright" },
			})

			-- 2. LSP接続時の共通キーマップ
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(event)
					local opts = { buffer = event.buf }
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
				end,
			})

			-- 3. Neovim 0.11 組み込み API で各LSPを設定・有効化
			-- nvim-lspconfig は mason-lspconfig 経由のインストール管理のみに使用
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { 'vim' } },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
						},
					},
				},
				terraformls = {},
				yamlls = {
					settings = {
						yaml = {
							schemas = {
								-- CloudFormationのスキーマ補完（命名規則を広めに対応）
								["https://raw.githubusercontent.com/awslabs/goformation/v4.18.4/schema/cloudformation.json"] = {
									"/*.cf.yaml",
									"/*.cfn.yaml",
									"/*-template.yaml",
									"/*_template.yaml",
									"/template.yaml",
									"/cloudformation/*.yaml",
									"/cfn/*.yaml",
									"/infra/*.yaml",
								},
							},
						},
					},
				},
				pyright = {},
			}

			for server, config in pairs(servers) do
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
		end
	},
}
