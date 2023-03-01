local plugins = {
	lsp = require("plugins.lsp")
}

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use "nvim-lua/plenary.nvim"


	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	})


	use {
		"windwp/nvim-autopairs",
		config = function()
			require('nvim-autopairs').setup({ map_bs = false, map_cr = false })
		end
	}

	use {
		"joshdick/onedark.vim",
		config = function()
		end
	}

	local _, capabilities = require("plugins.autocomplete").Register(use)
	-- todo: better handling of capabilities
	require("plugins.lsp").Register(use, capabilities)
	require("plugins.treesitter").Register(use)
	require("plugins.telescope").Register(use)
	require("plugins.tree").Register(use)
	require("plugins.git").Register(use)
	require("plugins.statusline").Register(use)
	require("plugins.bufferline").Register(use)
	vim.cmd("colorscheme onedark")
end)
