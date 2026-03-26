return {
	-- Mason: manage LSP servers
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"rust_analyzer",
				"ts_ls",
				"pyright",
				"lua_ls",
			},
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Shared on_attach for keymaps
			local on_attach = function(_, bufnr)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
				end

				map("gd", vim.lsp.buf.definition, "Go to definition")
				map("gD", vim.lsp.buf.declaration, "Go to declaration")
				map("gr", vim.lsp.buf.references, "Go to references")
				map("gi", vim.lsp.buf.implementation, "Go to implementation")
				map("K", vim.lsp.buf.hover, "Hover documentation")
				map("<leader>ca", vim.lsp.buf.code_action, "Code action")
				map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
				map("<leader>D", vim.lsp.buf.type_definition, "Type definition")
				map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
				map("]d", vim.diagnostic.goto_next, "Next diagnostic")
				map("<leader>dl", vim.diagnostic.setloclist, "Diagnostics list")
			end

			-- Rust
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					["rust-analyzer"] = {
						checkOnSave = { command = "clippy" },
					},
				},
			})

			-- TypeScript
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Python
			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})
		end,
	},
}
