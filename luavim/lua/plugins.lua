-- Setup lazy.nvim
require("lazy").setup({
	-- Plenary (common dependency)
	"nvim-lua/plenary.nvim",

	-- Core plugins with simple configs
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require('nvim-autopairs').setup({ map_bs = false, map_cr = false })
		end
	},

	-- Theme (updated to Lua version)
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require('onedark').setup({
				style = 'dark'
			})
			require('onedark').load()
		end
	},

	-- Kitty scrollback
	{
		'mikesmithgh/kitty-scrollback.nvim',
		enabled = true,
		lazy = true,
		cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
		event = { 'User KittyScrollbackLaunch' },
		config = function()
			require('kitty-scrollback').setup()
		end,
	},

	-- Load plugin modules
	{ import = "plugins.autocomplete" },
	{ import = "plugins.lsp" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.telescope" },
	{ import = "plugins.tree" },
	{ import = "plugins.git" },
	{ import = "plugins.statusline" },
	{ import = "plugins.bufferline" },
}, {
	-- Lazy.nvim options
	ui = {
		border = "rounded",
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})