local mod = {
	plugins = {
		{ 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }
	}
}

function mod.Setup(container)
	require("bufferline").setup {
		options = {

			hover = {
				enabled = true,
				delay = 200,
				reveal = { 'close' }
			},

			offsets = {
				{
					filetype = "neo-tree",
					text = "Explorer",
					highlight = "Directory",
					separator = true -- use a "true" to enable the default, or set your own character
				}
			}
		}
	}
end

return mod
