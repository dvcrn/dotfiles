-- helper to call native functions with some arguments
local wrap = function(func, ...)
	local args = { ... }
	return function()
		func(unpack(args))
	end
end

vim.keymap.set("n", "<Tab>", ":e#<CR>")
vim.keymap.set("n", "<leader>_r", ":luafile %<CR>")
vim.keymap.set("i", "fd", "<esc>")
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader>gs", ":!smerge %<CR>")

-- move panes with space h,l,j,k
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")

-- window splitting
vim.keymap.set("n", "<leader>wv", "<C-w>v<C-w>l")
vim.keymap.set("n", "<leader>wl", "<C-w>v<C-w>l")
vim.keymap.set("n", "<leader>wh", "<C-w>s<C-w>j")
vim.keymap.set("n", "<leader>wj", "<C-w>s<C-w>j")

-- diagnostic options
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '[q', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']q', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- buffers
-- vim.keymap.set("n", "<leader>bb", ":Buffers<CR>")
vim.keymap.set("n", "<leader>bd", ":b#<bar>bd#<CR>")
vim.keymap.set("n", "<leader>bc", ":b#<bar>bd#<CR>")
vim.keymap.set("n", "<leader>bx", ":b#<bar>bd#<CR>")
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
