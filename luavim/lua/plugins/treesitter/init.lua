return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
			'RRethy/nvim-treesitter-endwise',
		},
		config = function()
			-- vim.opt.foldmethod     = 'expr'
			-- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
			---WORKAROUND
			-- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
			-- 	group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
			-- 	callback = function()
			-- 		vim.opt.foldmethod = 'expr'
			-- 		vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
			-- 	end
			-- })
			---ENDWORKAROUND

			require 'nvim-treesitter.configs'.setup {
				-- Only install essential parsers on startup
				ensure_installed = { 
					"lua", 
					"vim", 
					"vimdoc",
					"query",
					"markdown",
					"markdown_inline",
					"bash",
					"regex",
					"diff",
					"git_config",
					"gitcommit",
					"git_rebase",
					"gitignore",
					"gitattributes",
				},
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				auto_install = true,
				-- List of parsers to ignore installing
				ignore_install = {},

				highlight = {
					enable = true,
					disable = { "c", "rust" },
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true
				},
				endwise = {
					enable = true,
				},
				textobjects = {
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@block.outer", desc = "Next class start" },
							--
							-- You can use regex matching and/or pass a list in a "query" key to group multiple queires.
							["]o"] = "@loop.*",
							-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							--
							-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@block.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
						-- Below will go to either the start or the end, whichever is closer.
						-- Use if you want more granular movements
						-- Make it even more gradual by adding multiple queries and regex.
						-- goto_next = {
						-- 	["]d"] = "@conditional.outer",
						-- },
						-- goto_previous = {
						-- 	["[d"] = "@conditional.outer",
						-- }
					},
				},
			}
		end
	}
}