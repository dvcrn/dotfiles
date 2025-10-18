return {
    -- Claude Code integration
    {
        "greggh/claude-code.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim", -- Required for git operations
        },
        cmd = { "ClaudeCode", "ClaudeCodeToggle" },
        keys = {
            { "<leader>ac", "<cmd>ClaudeCode<CR>",            desc = "Toggle Claude Code" },
            { "<leader>aC", "<cmd>ClaudeCode --continue<CR>", desc = "Claude Code Continue" },
        },
        config = function()
            require("claude-code").setup({
                -- Terminal window settings
                window = {
                    split_ratio = 0.35,     -- 35% of screen for the terminal window
                    position = "botright",  -- Bottom right split
                    enter_insert = true,    -- Auto-enter insert mode
                    hide_numbers = true,    -- Clean terminal look
                    hide_signcolumn = true, -- Clean terminal look
                    -- Alternative floating window config (uncomment to use)
                    -- position = "float",
                    -- float = {
                    --   width = "85%",
                    --   height = "85%",
                    --   row = "center",
                    --   col = "center",
                    --   relative = "editor",
                    --   border = "rounded",
                    -- },
                },
                -- File refresh settings
                refresh = {
                    enable = true,             -- Auto-reload files changed by Claude
                    updatetime = 100,          -- Fast update when Claude is active
                    timer_interval = 1000,     -- Check for changes every second
                    show_notifications = true, -- Notify when files are reloaded
                },
            })

            -- Additional keymaps for Claude Code
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "claudecode",
                callback = function()
                    local opts = { buffer = true, silent = true }
                    -- Quick exit from Claude Code terminal
                    vim.keymap.set("n", "q", "<cmd>ClaudeCode<CR>", opts)
                    vim.keymap.set("n", "<Esc>", "<cmd>ClaudeCode<CR>", opts)
                end,
            })
        end,
    },

    -- Avante.nvim - Cursor AI IDE experience in Neovim
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false,
        build = "make", -- For Windows: "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            "MeanderingProgrammer/render-markdown.nvim",
        },
        opts = {
            -- Provider configuration
            provider = "claude", -- Options: "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot"

            -- Providers configuration (new format)
            providers = {
                claude = {
                    endpoint = "https://claude-code-proxy.dsh.workers.dev",
                    model = "claude-4-sonnet-20241022",
                    timeout = 30000,
                    extra_request_body = {
                        temperature = 0,
                        max_tokens = 4096,
                    },
                },
                gemini = {
                    endpoint = "https://gemini-code-assist-proxy.dsh.workers.dev",
                    model = "gemini-2.5-pro",
                    timeout = 30000,
                    extra_request_body = {
                        temperature = 0,
                        max_tokens = 4096,
                    },
                },
                -- OpenAI configuration example:
                -- openai = {
                --   endpoint = "https://api.openai.com/v1",
                --   model = "gpt-4o-2024-11-20",
                --   timeout = 30000,
                --   extra_request_body = {
                --     temperature = 0,
                --     max_tokens = 4096,
                --   },
                -- },
            },

            -- Behavior settings
            auto_suggestions_provider = "claude", -- Auto-suggest provider
            behaviour = {
                auto_suggestions = false,         -- Enable/disable auto-suggestions
                auto_set_highlight_group = true,
                auto_set_keymaps = true,
                auto_apply_diff_after_generation = false,
                support_paste_from_clipboard = false,
            },

            -- Keymappings (will be set if not already bound)
            mappings = {
                ask = "<leader>aa",     -- Ask AI about code
                edit = "<leader>ae",    -- Edit code with AI
                refresh = "<leader>ar", -- Refresh AI response
                diff = {
                    ours = "co",        -- Choose our version
                    theirs = "ct",      -- Choose AI version
                    all_theirs = "ca",  -- Accept all AI changes
                    both = "cb",        -- Choose both versions
                    cursor = "cc",      -- Choose at cursor
                    next = "]x",        -- Next diff
                    prev = "[x",        -- Previous diff
                },
                suggestion = {
                    accept = "<M-l>",  -- Accept suggestion
                    next = "<M-]>",    -- Next suggestion
                    prev = "<M-[>",    -- Previous suggestion
                    dismiss = "<C-]>", -- Dismiss suggestion
                },
                jump = {
                    next = "]]", -- Jump to next section
                    prev = "[[", -- Jump to previous section
                },
                submit = {
                    normal = "<CR>",  -- Submit in normal mode
                    insert = "<C-s>", -- Submit in insert mode
                },
                sidebar = {
                    switch_windows = "<Tab>",           -- Switch between windows
                    reverse_switch_windows = "<S-Tab>", -- Reverse switch
                },
            },

            -- Windows configuration
            windows = {
                position = "right", -- "right" | "left" | "top" | "bottom"
                wrap = true,        -- Wrap lines in windows
                width = 30,         -- Default width percentage
                sidebar_header = {
                    align = "center",
                    rounded = true,
                },
            },

            -- Highlights configuration
            highlights = {
                diff = {
                    current = "DiffText",
                    incoming = "DiffAdd",
                },
            },

            -- Diff configuration
            diff = {
                autojump = true,       -- Auto-jump to first diff
                list_opener = "copen", -- Command to open diff list
            },
        },
        keys = {
            -- Additional convenience mappings
            { "<leader>at", "<cmd>AvanteToggle<cr>",         desc = "Toggle Avante" },
            { "<leader>af", "<cmd>AvanteFocus<cr>",          desc = "Focus Avante" },
            { "<leader>as", "<cmd>AvanteSwitchProvider<cr>", desc = "Switch AI Provider" },
            { "<leader>ab", "<cmd>AvanteShowBundle<cr>",     desc = "Show Avante Bundle" },
            -- Visual mode mappings
            { "<leader>aa", "<cmd>AvanteAsk<cr>",            mode = "v",                 desc = "Ask AI about selection" },
            { "<leader>ae", "<cmd>AvanteEdit<cr>",           mode = "v",                 desc = "Edit selection with AI" },
        },
        config = function(_, opts)
            require("avante").setup(opts)

            -- Set up API key environment variable hints
            vim.api.nvim_create_user_command("AvanteKeys", function()
                print("Set one of these environment variables:")
                print("  ANTHROPIC_API_KEY or AVANTE_ANTHROPIC_API_KEY (for Claude)")
                print("  OPENAI_API_KEY or AVANTE_OPENAI_API_KEY (for OpenAI)")
                print("  GEMINI_API_KEY or AVANTE_GEMINI_API_KEY (for Gemini)")
                print("  COHERE_API_KEY or AVANTE_COHERE_API_KEY (for Cohere)")
                print("Current provider: " .. opts.provider)
            end, {})
        end,
    },

    -- Future AI plugins can be added here
}
