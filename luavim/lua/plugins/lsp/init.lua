local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
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
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
	vim.keymap.set('n', ',=', function() vim.lsp.buf.format { async = true } end, bufopts)
	vim.keymap.set('n', ',e', vim.lsp.buf.code_action, bufopts)
end

return {
	-- Mason
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason LSP config
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { 
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Setup capabilities for nvim-cmp
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lspconfig = require('lspconfig')

			require("mason-lspconfig").setup({
				-- Auto-install LSPs when opening files
				automatic_installation = true,
				
				-- Optional: ensure these specific servers are always installed
				ensure_installed = {
					"lua_ls",
					"bashls", 
					"gopls",
					"tsserver",
				},
			})
			
			-- Auto-configure all Mason-installed servers
			vim.api.nvim_create_autocmd("User", {
				pattern = "MasonLspInstall",
				callback = function(event)
					local server_name = event.data.name
					-- Default setup for all servers
					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,
			})
			
			-- Setup servers that are already installed
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.get_installed_servers(function(servers)
				for _, server_name in ipairs(servers) do
					if server_name == "lua_ls" then
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							on_attach = on_attach,
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
										checkThirdParty = false,
									},
									telemetry = {
										enable = false,
									},
								},
							},
						})
					elseif server_name == "elixirls" then
						lspconfig.elixirls.setup({
							capabilities = capabilities,
							on_attach = on_attach,
							cmd = { vim.fn.expand("$HOME/syncsrc/elixir-ls/language_server.sh") },
						})
					else
						lspconfig[server_name].setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end
				end
			end)
		end,
	},

	-- Mason Tool Installer for comprehensive tool management
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSPs
					"lua-language-server",
					"bash-language-server",
					"gopls",
					"typescript-language-server",
					"pyright",
					"rust-analyzer",
					"elixir-ls",
					"dockerfile-language-server",
					"yaml-language-server",
					"json-lsp",
					
					-- Formatters  
					"stylua",
					"prettier",
					"gofmt",
					"goimports",
					"black",
					"isort",
					"shfmt",
					
					-- Linters
					"eslint_d",
					"shellcheck",
					"golangci-lint",
					"ruff",
					"yamllint",
				},
				
				-- Auto-update tools
				auto_update = false,
				
				-- Run installer on startup
				run_on_start = true,
				
				-- Debounce installation/update events
				start_delay = 3000, -- milliseconds
			})
		end,
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					go = { "gofmt", "goimports" },
					sh = { "shfmt" },
					bash = { "shfmt" },
					-- Use LSP formatting for other filetypes
					["_"] = { "trim_whitespace" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>f", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},

	-- Linting
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				python = { "ruff" },
				go = { "golangcilint" },
				sh = { "shellcheck" },
				bash = { "shellcheck" },
				yaml = { "yamllint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	-- Trouble
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
}