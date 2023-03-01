local mod = {}

function mod.Register(use)
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use {
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	}

	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	local telescope = require("telescope")
	local actions = require('telescope.actions')
	local fb_actions = telescope.extensions.file_browser.actions
	telescope.setup {
		defaults = {
			mappings = {
				i = {
					["<C-n>"] = actions.move_selection_next,
					["<C-p>"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					["<ESC>"] = actions.close,
				},
			},
		},
		extensions = {
			file_browser = {
				previewer = false,
				-- theme = "ivy",
				-- disables netrw and use telescope-file-browser in its place
				hijack_netrw = true,
				mappings = {
					["i"] = {
						-- your custom insert mode mappings
						-- need to figure out how to do this so it doesn't apply to netrw
						-- ["<CR>"] = fb_actions.create_from_prompt,
					},
					["n"] = {
						-- your custom normal mode mappings
					},
				},
			},
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			}
		},
	}
	telescope.load_extension "file_browser"
	telescope.load_extension "fzf"

	local builtin = require('telescope.builtin')
	local function find_files()
		require('telescope.builtin').find_files({
			-- or new custom picker's attach_mappings field:
			-- find_command = { 'fd', '--type', 'f', '--no-ignore-vcs', '--color=never', '--hidden', '--follow' },
			prompt_prefix = '📄 '
		})
	end

	local function git_or_find_files()
		local results = require('telescope.utils').get_os_command_output({ 'git', 'rev-parse', '--git-dir' })

		if results[1] then
			require('telescope.builtin').git_files({
				-- or new custom picker's attach_mappings field:
				prompt_prefix = ' ',
				show_untracked = true
			})
		else
			find_files()
		end
	end

	local function advanced_new_file()
		--local buf = vim.api.nvim_get_current_buf()
		--local bufname = vim.api.nvim_buf_get_name(buf)
		local filepath = vim.fn.expand('%:p:h')

		telescope.extensions.file_browser.file_browser(
			require("telescope.themes").get_dropdown({
				cwd = filepath,
				previewer = false,
				files = true,
				display_stat = false,
			})
		)
	end

	vim.keymap.set('n', '<c-p>', git_or_find_files, {})
	vim.keymap.set('n', '<leader>pf', git_or_find_files, {})
	vim.keymap.set('n', '<leader>pc', advanced_new_file, {})
	vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
	vim.keymap.set('n', '<c-b>', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

	mod.hogehoge = "abc"

	return telescope
end

return mod
