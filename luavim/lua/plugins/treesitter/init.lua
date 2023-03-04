local mod = {
	plugins = {
		{
			'nvim-treesitter/nvim-treesitter',
			run = function()
				local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
				ts_update()
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			after = "nvim-treesitter",
			requires = "nvim-treesitter/nvim-treesitter",
		},
		"RRethy/nvim-treesitter-endwise"
	}
}

function mod.Setup(container)
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
		-- A list of parser names, or "all" (the four listed parsers should always be installed)
		-- ensure_installed = { "lua", "vim", "elixir" },
		ensure_installed = "all",
		sync_install = false,

		auto_install = true,
		-- ignore_install = { "" },

		highlight = {
			enable = true,
			disable = { "c", "rust" },
			additional_vim_regex_highlighting = false,
		},
		require 'nvim-treesitter.configs'.setup {
			indent = {
				enable = true
			}
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

return mod
