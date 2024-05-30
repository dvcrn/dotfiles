local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wl', function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
	vim.keymap.set('n', ',=', function() vim.lsp.buf.format { async = true } end, bufopts)
	vim.keymap.set('n', ',e', vim.lsp.buf.code_action, bufopts)
end


local mod = {
	plugins = {
		{
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		"lukas-reineke/lsp-format.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"folke/trouble.nvim",
	},
	setup = { { "capabilities" }, function(capabilities)
		require("mason").setup()

		local null_ls = require("null-ls")
		null_ls.setup({
			on_attach = on_attach,
			sources = {
				null_ls.builtins.code_actions.gitsigns,
				-- null_ls.builtins.diagnostics.credo -- elixir
			}
		})

		require("trouble").setup({
		})

		require("mason-lspconfig").setup({
			ensure_installed = { "bashls", "docker_compose_language_service", "elixirls", "gopls", "lua_ls",
				"vimls" },
		})


		-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for a list with all servers
		-- or :help lspconfig-all
		require("mason-lspconfig").setup_handlers({
			["bashls"] = function()
				require 'lspconfig'.bashls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,
			["gopls"] = function()
				require 'lspconfig'.gopls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,
			["lua_ls"] = function()
				require 'lspconfig'.lua_ls.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						Lua = {
							runtime = {
								version = 'LuaJIT',
							},
							diagnostics = {
								globals = { 'vim' },
							},
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
							},
							telemetry = {
								enable = false,
							},
						},
					},
				})
			end,
			["elixirls"] = function()
				require 'lspconfig'.elixirls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					cmd = { vim.fn.expand("$HOME/syncsrc/elixir-ls/language_server.sh") },
				})
			end,
			["tsserver"] = function()
				require 'lspconfig'.tsserver.setup({
					capabilities = capabilities,
					on_attach = on_attach
				})
			end
		})
	end }
}

return mod;
