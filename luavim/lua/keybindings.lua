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
vim.keymap.set("n", "<leader>gs", ":silent !smerge %<CR>")

-- beginning of line / end of line with C-e, C-a
vim.keymap.set("n", "<C-e>", "$")
vim.keymap.set("n", "<C-a>", "^")
vim.keymap.set("i", "<C-e>", "<esc>$a")
vim.keymap.set("i", "<C-a>", "<esc>^i")

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
vim.keymap.set("n", "<leader>bx", ":bd<CR>")
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")

if vim.g.neovide then
	vim.g.neovide_input_use_logo = 1

	vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

	vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
	vim.keymap.set('v', '<D-c>', '"+y')  -- Copy
	vim.keymap.set('n', '<D-v>', '"+P')  -- Paste normal mode
	vim.keymap.set('v', '<D-v>', '"+P')  -- Paste visual mode
	vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
	vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

	-- buffer navigation
	vim.keymap.set('n', '<S-D-n>', ':bnext<CR>')
	vim.keymap.set('n', '<S-D-p>', ':bprev<CR>')

	vim.keymap.set('n', '<S-D-]>', ':bnext<CR>')
	vim.keymap.set('n', '<S-D-[>', ':bprev<CR>')

	vim.keymap.set('n', '<S-D-l>', ':bnext<CR>')
	vim.keymap.set('n', '<S-D-h>', ':bprev<CR>')

	vim.keymap.set('n', '<D-w>', ':bd<CR>') -- close with cmd-w

	vim.keymap.set('n', '<D-a>', 'ggVG') -- select all with cmd-a
end
