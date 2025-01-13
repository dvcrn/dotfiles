local ensure_packer = function()
    local fn = vim.fn

    local install_dir = fn.expand("~/.local/share/nvim/site/pack/packer/start/")
    local install_path = install_dir .. "packer.nvim"

    if fn.empty(fn.glob(install_path)) > 0 then
        print("config is empty, installing packer....")
        print(install_path)

        fn.system({ 'mkdir', '-p', install_dir })
        fn.system({ 'git', 'clone', '--depth', '1', 'git@github.com:wbthomason/packer.nvim.git', install_path })

        vim.cmd [[packadd packer.nvim]]

        print("packer.nvim has been installed. please restart neovim and run :PackerInstall")
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require "options"
require "keybindings"
require "style"
require "plugins"
