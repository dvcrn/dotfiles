if vim.g.neovide then
	vim.o.guifont = "OperatorMonoSSmLig Nerd Font:h18"
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_input_use_logo = 1

	vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
	vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
	vim.keymap.set('v', '<D-c>', '"+y') -- Copy
	vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
	vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
	vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
	vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

	vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

	-- vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
	-- vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
	-- vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
	-- vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

	vim.keymap.set('n', '<S-D-n>', ':bnext<CR>')
	vim.keymap.set('n', '<S-D-p>', ':bprev<CR>')

	vim.keymap.set('n', '<S-D-]>', ':bnext<CR>')
	vim.keymap.set('n', '<S-D-[>', ':bprev<CR>')

	vim.keymap.set('n', '<S-D-l>', ':bnext<CR>')
	vim.keymap.set('n', '<S-D-h>', ':bprev<CR>')
	-- vim.api.nvim_set_keymap('n', '<D-S-]>', ':bnext<CR>', { noremap = true, silent = true })
end

vim.cmd [[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]]
