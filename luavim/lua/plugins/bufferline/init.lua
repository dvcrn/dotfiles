return {
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
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
	}
}