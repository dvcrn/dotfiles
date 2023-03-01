vim.g.mapleader = " "

local set = vim.opt

set.showcmd = true -- show current cmd
set.cursorline = true -- highlight the entire line
set.autoindent = true -- auto indent
set.wrap = true -- line wrapping
set.autoread = true -- automatically reload file when changed
set.clipboard = 'unnamedplus' -- use system clipboard

set.laststatus = 2
set.cmdheight = 2 -- and use a two-line tall status line
set.showcmd = true -- show the command
set.showmatch = true -- show matching bracket

-- numbers and make them relative
set.relativenumber = true
set.number = true

set.title = true
set.titlestring = "%f %h%m%r%w - %{substitute(getcwd(),$HOME, '~', '')} - %{v:progname}"

set.showtabline = 2 -- always show tabs

set.termguicolors = true
