# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration written in Lua that uses Lazy.nvim as the plugin manager. The configuration implements a modular architecture for plugin management.

## Architecture

### Core Structure
- **init.lua**: Entry point that bootstraps Lazy.nvim and loads core modules
- **lua/options.lua**: Neovim settings and options
- **lua/keybindings.lua**: Global keybindings and leader key mappings
- **lua/style.lua**: UI and appearance settings
- **lua/plugins.lua**: Main plugin configuration using Lazy.nvim
- **lua/plugins/**: Individual plugin configurations (one file per plugin/concern)

### Plugin System

The configuration uses Lazy.nvim's modular loading system:
- Main plugins are defined in `plugins.lua`
- Complex plugin configurations are separated into modules under `lua/plugins/`
- Each module returns a table of plugin specifications
- Lazy loading is used to improve startup performance

## Common Commands

### Plugin Management (Lazy.nvim)
- `:Lazy` - Open Lazy UI
- `:Lazy sync` - Sync plugins (install, update, clean)
- `:Lazy update` - Update plugins
- `:Lazy install` - Install missing plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy profile` - Profile plugin load times

### LSP Commands
- `:Mason` - Open Mason UI for LSP server management
- `:LspInfo` - Show LSP server status
- `:TroubleToggle` - Toggle diagnostics panel

### Development
There are no build, lint, or test commands for the configuration itself. Changes take effect on Neovim restart or by sourcing files.

## Key Keybindings

- **Leader Key**: `<Space>`
- **Plugin Management**: `<leader>_` prefix (e.g., `<leader>_l` for Lazy UI)
- **LSP**: `<leader>l` prefix for LSP commands
- **Telescope**: `<leader>f` prefix for fuzzy finding
- **Git**: `<leader>g` prefix for Git operations
- **Terminal**: `<leader>t` for terminal operations
- **Buffers**: `<leader>b` prefix for buffer operations
- **AI**: `<leader>a` prefix for AI tools (e.g., `<leader>ac` for Claude Code)

## Language Server Configuration

LSP servers are managed by Mason and configured in `lua/plugins/lsp.lua`:
- bashls, docker_compose_language_service, gopls, lua_ls, vimls, tsserver
- Custom elixirls path: `~/syncsrc/elixir-ls/language_server.sh`
- Auto-formatting on save is enabled via conform.nvim

## Plugin Highlights

### Replaced/Updated Plugins
- **Plugin Manager**: Packer.nvim → Lazy.nvim
- **Theme**: onedark.vim → onedark.nvim (Lua version)
- **Formatting/Linting**: null-ls → conform.nvim + nvim-lint

### AI Integration
- **claude-code.nvim**: Direct Claude Code integration in Neovim terminal
  - Toggle with `<leader>ac`
  - Continue conversation with `<leader>aC`
  - Auto-reloads files modified by Claude Code
  - Configurable split or floating window

- **avante.nvim**: Cursor AI IDE-like experience in Neovim
  - Ask AI about code: `<leader>aa` (normal/visual mode)
  - Edit with AI assistance: `<leader>ae` (normal/visual mode)
  - Toggle Avante sidebar: `<leader>at`
  - Focus Avante window: `<leader>af`
  - Switch AI providers: `<leader>as`
  - Supports Claude, OpenAI, Gemini, Cohere, and more
  - Advanced diff view with `co`/`ct`/`ca` for choosing changes
  - RAG features for context-aware code understanding

### Performance Optimizations
- Treesitter only installs essential parsers on startup
- Additional language parsers are auto-installed on demand
- Plugins are lazy-loaded based on events and commands

## Platform-Specific Features

- **Neovide Support**: GUI-specific settings and keybindings
- **Kitty Terminal**: Special scrollback integration via kitty-scrollback.nvim

## Dependencies

- Neovim >= 0.7.0 (recommended >= 0.10.0)
- Git (for plugin installation)
- Language servers installed via Mason or manually (for elixirls)

## Known Issues

- Some plugins may show deprecation warnings for `vim.tbl_add_reverse_lookup` - these are temporary and will be fixed as plugins update
- Deprecation warnings are currently suppressed in `options.lua`

## AI Setup

Both AI plugins require API keys to function:

### Claude Code
- Uses your system's Claude Code installation
- No additional API key needed if Claude Code is already configured

### Avante.nvim
Set one of these environment variables:
- `ANTHROPIC_API_KEY` or `AVANTE_ANTHROPIC_API_KEY` (for Claude)
- `OPENAI_API_KEY` or `AVANTE_OPENAI_API_KEY` (for OpenAI)
- `GEMINI_API_KEY` or `AVANTE_GEMINI_API_KEY` (for Gemini)
- `COHERE_API_KEY` or `AVANTE_COHERE_API_KEY` (for Cohere)

Run `:AvanteKeys` to see current configuration.